"""Docker-based Lambda runtime provider implementing ICompute.

Runs Lambda handlers inside Docker containers with memory and CPU limits
enforced. Source code is mounted as a read-only volume so changes on disk
are immediately visible without rebuilding.

Container strategy: lazy warm containers with ``docker exec``.

- ``start()`` validates that the Docker daemon is reachable.
- ``invoke()`` creates a warm container on first call (lazy), then uses
  ``docker exec`` to run the bootstrap script, piping the event via stdin
  and reading the result from stdout.
- ``stop()`` stops and removes the container if one was created.
"""

from __future__ import annotations

import asyncio
import json
import os
import select
import subprocess
import time
from pathlib import Path

from lws.interfaces import (
    ComputeConfig,
    ICompute,
    InvocationResult,
    LambdaContext,
    ProviderStartError,
    ProviderStatus,
)
from lws.logging.logger import get_logger

_logger = get_logger("ldk.docker-compute")

_BOOTSTRAP_DIR = Path(__file__).parent

# AWS Lambda allocates 1 vCPU per 1769 MB of memory.
_MB_PER_VCPU = 1769

# Minimum CPU allocation in nano-CPUs (128 millicores).
_MIN_NANO_CPUS = 128_000_000

# Runtime → Docker image mapping.
_RUNTIME_IMAGES: dict[str, str] = {
    "nodejs14.x": "node:14-slim",
    "nodejs16.x": "node:16-slim",
    "nodejs18.x": "node:18-slim",
    "nodejs20.x": "node:20-slim",
    "nodejs22.x": "node:22-slim",
    "python3.8": "python:3.8-slim",
    "python3.9": "python:3.9-slim",
    "python3.10": "python:3.10-slim",
    "python3.11": "python:3.11-slim",
    "python3.12": "python:3.12-slim",
    "python3.13": "python:3.13-slim",
}


class DockerCompute(ICompute):
    """ICompute implementation that runs Lambda handlers inside Docker containers.

    Each function gets a warm container that stays alive between invocations.
    The bootstrap scripts (``invoker.js`` / ``python_bootstrap.py``) are
    mounted read-only at ``/var/bootstrap`` and the function source code is
    mounted read-only at ``/var/task``.
    """

    def __init__(self, config: ComputeConfig, sdk_env: dict[str, str]) -> None:
        self._config = config
        self._sdk_env = sdk_env
        self._status = ProviderStatus.STOPPED
        self._container = None
        self._client = None

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        return f"lambda:{self._config.function_name}"

    async def start(self) -> None:
        """Validate that the Docker daemon is reachable.

        Container creation is deferred to the first ``invoke()`` call.
        """
        try:
            import docker
        except ImportError as exc:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError(
                "Docker backend requires 'pip install local-web-services[docker]' "
                "and a running Docker daemon."
            ) from exc

        try:
            self._client = docker.from_env()
            self._client.ping()
        except Exception as exc:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError(f"Cannot connect to Docker daemon: {exc}") from exc

        self._status = ProviderStatus.RUNNING

    def _ensure_container(self) -> None:
        """Create the warm container if it doesn't exist yet (lazy init)."""
        if self._container is not None:
            return

        image = self._resolve_image()
        container_name = f"ldk-{self._config.function_name}"

        # Remove any stale container from a previous run.
        try:
            stale = self._client.containers.get(container_name)
            stale.remove(force=True)
        except Exception:
            pass

        self._container = self._client.containers.run(
            image,
            command="sleep infinity",
            detach=True,
            name=container_name,
            volumes={
                str(self._config.code_path.resolve()): {
                    "bind": "/var/task",
                    "mode": "ro",
                },
                str(_BOOTSTRAP_DIR.resolve()): {
                    "bind": "/var/bootstrap",
                    "mode": "ro",
                },
            },
            mem_limit=f"{self._config.memory_size}m",
            nano_cpus=self._calculate_nano_cpus(),
            environment=self._build_container_env(),
            extra_hosts={"host.docker.internal": "host-gateway"},
            init=True,
        )

        _logger.info(
            "Started container %s (image=%s, memory=%dMB)",
            container_name,
            image,
            self._config.memory_size,
        )

    async def stop(self) -> None:
        self._destroy_container()
        self._status = ProviderStatus.STOPPED

    def _destroy_container(self) -> None:
        """Stop and remove the container. Safe to call when no container exists."""
        if self._container is None:
            return
        try:
            self._container.stop(timeout=2)
        except Exception:
            pass
        try:
            self._container.remove(force=True)
        except Exception:
            pass
        self._container = None

    async def health_check(self) -> bool:
        return self._status is ProviderStatus.RUNNING

    # -- Invocation -----------------------------------------------------------

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        if self._client is None:
            return InvocationResult(
                payload=None,
                error="Docker client not initialized — call start() first",
                duration_ms=0.0,
                request_id=context.aws_request_id,
            )

        try:
            self._ensure_container()
        except Exception as exc:
            return InvocationResult(
                payload=None,
                error=f"Failed to start container: {exc}",
                duration_ms=0.0,
                request_id=context.aws_request_id,
            )

        func_name = self._config.function_name
        context_dict = {
            "function_name": context.function_name,
            "memory_limit_in_mb": context.memory_limit_in_mb,
            "timeout_seconds": context.timeout_seconds,
            "aws_request_id": context.aws_request_id,
            "invoked_function_arn": context.invoked_function_arn,
        }

        cmd = self._build_exec_cmd()
        env_vars = self._build_exec_env(context)
        event_json = json.dumps(event)

        start = time.monotonic()
        result, timed_out = await self._run_exec(cmd, env_vars, event_json)
        duration_ms = (time.monotonic() - start) * 1000

        if timed_out:
            # Kill the container on timeout — mirrors real Lambda behaviour
            # where the execution environment is destroyed. A fresh container
            # will be created on the next invocation via _ensure_container().
            self._destroy_container()
            _logger.log_lambda_invocation(
                function_name=func_name,
                request_id=context.aws_request_id,
                duration_ms=duration_ms,
                status="TIMEOUT",
                error=f"Task timed out after {self._config.timeout} seconds",
                event=event,
                context=context_dict,
            )
            return InvocationResult(
                payload=None,
                error=f"Task timed out after {self._config.timeout} seconds",
                duration_ms=duration_ms,
                request_id=context.aws_request_id,
            )
        # Destroy the container after each invocation so it doesn't linger
        # in ``docker ps``.  A fresh container is created on the next call
        # via ``_ensure_container()``.
        self._destroy_container()

        invocation_result = self._parse_result(result, duration_ms, context.aws_request_id)
        _logger.log_lambda_invocation(
            function_name=func_name,
            request_id=context.aws_request_id,
            duration_ms=duration_ms,
            status="ERROR" if invocation_result.error else "OK",
            error=invocation_result.error,
            event=event,
            context=context_dict,
            result=invocation_result.payload,
        )
        return invocation_result

    # -- Internal helpers -----------------------------------------------------

    def _resolve_image(self) -> str:
        runtime = self._config.runtime
        image = _RUNTIME_IMAGES.get(runtime)
        if image:
            return image
        # Fallback: try prefix matching
        if runtime.startswith("nodejs"):
            return "node:20-slim"
        if runtime.startswith("python"):
            return "python:3.12-slim"
        return "node:20-slim"

    def _calculate_nano_cpus(self) -> int:
        nano = int((self._config.memory_size / _MB_PER_VCPU) * 1_000_000_000)
        return max(nano, _MIN_NANO_CPUS)

    def _build_container_env(self) -> dict[str, str]:
        """Build environment variables for the container.

        Rewrites localhost endpoint URLs to ``host.docker.internal`` so the
        container can reach services running on the host.
        """
        env: dict[str, str] = {}
        env.update(self._config.environment)
        for key, value in self._sdk_env.items():
            env[key] = self._rewrite_localhost(value)
        env["LDK_HANDLER"] = self._config.handler
        env["LDK_CODE_PATH"] = "/var/task"
        env["AWS_LAMBDA_FUNCTION_NAME"] = self._config.function_name
        env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] = str(self._config.memory_size)
        return env

    def _build_exec_env(self, context: LambdaContext) -> list[str]:
        """Build per-invocation env vars passed to ``docker exec``."""
        return [
            f"LDK_REQUEST_ID={context.aws_request_id}",
            f"LDK_FUNCTION_ARN={context.invoked_function_arn}",
            f"LDK_TIMEOUT={self._config.timeout}",
        ]

    def _build_exec_cmd(self) -> list[str]:
        """Build the command run inside the container via ``docker exec``.

        Wraps the bootstrap in ``timeout -s KILL`` so the runtime process is
        forcibly terminated even if it doesn't call ``process.exit()`` or
        ``sys.exit()``.
        """
        runtime = self._config.runtime
        timeout_secs = int(self._config.timeout)
        if runtime.startswith("python"):
            return [
                "timeout",
                "-s",
                "KILL",
                str(timeout_secs),
                "python3",
                "/var/bootstrap/python_bootstrap.py",
            ]
        return [
            "timeout",
            "-s",
            "KILL",
            str(timeout_secs),
            "node",
            "/var/bootstrap/invoker.js",
        ]

    @staticmethod
    def _rewrite_localhost(value: str) -> str:
        """Replace ``127.0.0.1`` and ``localhost`` with ``host.docker.internal``."""
        return value.replace("127.0.0.1", "host.docker.internal").replace(
            "localhost", "host.docker.internal"
        )

    async def _run_exec(
        self, cmd: list[str], env_vars: list[str], event_json: str
    ) -> tuple[str, bool]:
        """Run ``docker exec`` via the CLI and return (stdout, timed_out)."""
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(None, self._run_exec_sync, cmd, env_vars, event_json)

    @staticmethod
    def _read_json_from_fd(fd: int, timeout: float) -> tuple[bytes, bool]:
        """Read from *fd* using non-blocking I/O until a complete JSON object
        is received or *timeout* seconds elapse.

        Returns ``(data, timed_out)``.
        """
        os.set_blocking(fd, False)
        output = b""
        deadline = time.monotonic() + timeout

        while True:
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                return output, True

            ready, _, _ = select.select([fd], [], [], min(remaining, 1.0))
            if not ready:
                continue
            try:
                chunk = os.read(fd, 65536)
            except BlockingIOError:
                continue
            if not chunk:
                break  # EOF — process closed stdout or exited
            output += chunk
            try:
                json.loads(output)
                break  # Complete JSON object received
            except (json.JSONDecodeError, UnicodeDecodeError):
                continue  # incomplete — keep reading

        return output, False

    def _run_exec_sync(
        self, cmd: list[str], env_vars: list[str], event_json: str
    ) -> tuple[str, bool]:
        """Run the bootstrap script via ``docker exec`` CLI subprocess.

        Uses non-blocking I/O to detect when a complete JSON response has
        been received, then returns immediately *without* waiting for the
        process to exit.  This handles runtimes that don't explicitly call
        ``process.exit()`` (e.g. Node.js with active SDK keep-alive
        connections).

        Returns ``(stdout_str, timed_out)``.
        """
        docker_cmd = ["docker", "exec", "-i"]
        for env in env_vars:
            docker_cmd.extend(["-e", env])
        docker_cmd.append(self._container.id)
        docker_cmd.extend(cmd)

        proc = subprocess.Popen(
            docker_cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )

        # Send the event payload and close stdin so the bootstrap reads EOF.
        try:
            proc.stdin.write(event_json.encode())
            proc.stdin.close()
        except BrokenPipeError:
            pass

        output, timed_out = self._read_json_from_fd(proc.stdout.fileno(), self._config.timeout)

        # Collect stderr (best-effort, non-blocking).
        stderr = b""
        try:
            os.set_blocking(proc.stderr.fileno(), False)
            stderr = os.read(proc.stderr.fileno(), 65536)
        except (BlockingIOError, OSError):
            pass

        # Kill the docker-exec client process.  The container itself is
        # cleaned up separately by the caller.
        try:
            proc.kill()
        except OSError:
            pass
        try:
            proc.wait(timeout=2)
        except subprocess.TimeoutExpired:
            pass

        if stderr:
            _logger.debug(
                "[%s] stderr: %s",
                self._config.function_name,
                stderr.decode(errors="replace").rstrip(),
            )

        return output.decode(errors="replace"), timed_out

    @staticmethod
    def _parse_result(raw: str, duration_ms: float, request_id: str) -> InvocationResult:
        """Parse the JSON emitted by the bootstrap script into an InvocationResult."""
        try:
            data = json.loads(raw)
        except json.JSONDecodeError:
            return InvocationResult(
                payload=None,
                error=f"Failed to parse container output: {raw!r}",
                duration_ms=duration_ms,
                request_id=request_id,
            )

        if "error" in data:
            err = data["error"]
            error_message = err.get("errorMessage", str(err)) if isinstance(err, dict) else str(err)
            return InvocationResult(
                payload=None,
                error=error_message,
                duration_ms=duration_ms,
                request_id=request_id,
            )

        return InvocationResult(
            payload=data.get("result"),
            error=None,
            duration_ms=duration_ms,
            request_id=request_id,
        )
