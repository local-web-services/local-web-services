"""Docker-based Lambda runtime provider implementing ICompute.

Runs Lambda handlers inside Docker containers with memory and CPU limits
enforced. Source code is mounted as a read-only volume so changes on disk
are immediately visible without rebuilding.

Container strategy: warm containers with ``docker exec``.

- ``start()`` creates a long-lived container running ``sleep infinity``.
- ``invoke()`` runs ``docker exec`` to execute the bootstrap script inside
  the warm container, piping the event via stdin and reading the result
  from stdout.
- ``stop()`` stops and removes the container.
"""

from __future__ import annotations

import asyncio
import json
import logging
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

_logger = logging.getLogger("ldk.docker-compute")

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
            raise ProviderStartError(
                f"Cannot connect to Docker daemon: {exc}"
            ) from exc

        image = self._resolve_image()
        container_name = f"ldk-{self._config.function_name}"

        # Remove any stale container from a previous run.
        try:
            stale = self._client.containers.get(container_name)
            stale.remove(force=True)
        except Exception:
            pass

        try:
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
            )
        except Exception as exc:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError(
                f"Failed to start Docker container for {self._config.function_name}: {exc}"
            ) from exc

        _logger.info(
            "Started container %s (image=%s, memory=%dMB)",
            container_name,
            image,
            self._config.memory_size,
        )
        self._status = ProviderStatus.RUNNING

    async def stop(self) -> None:
        if self._container is not None:
            try:
                self._container.stop(timeout=2)
            except Exception:
                pass
            try:
                self._container.remove(force=True)
            except Exception:
                pass
            self._container = None
        self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        return self._status is ProviderStatus.RUNNING

    # -- Invocation -----------------------------------------------------------

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        if self._container is None:
            return InvocationResult(
                payload=None,
                error="Container not started",
                duration_ms=0.0,
                request_id=context.aws_request_id,
            )

        cmd = self._build_exec_cmd()
        env_vars = self._build_exec_env(context)
        event_json = json.dumps(event)

        start = time.monotonic()
        try:
            result = await asyncio.wait_for(
                self._run_exec(cmd, env_vars, event_json),
                timeout=self._config.timeout,
            )
        except TimeoutError:
            duration_ms = (time.monotonic() - start) * 1000
            return InvocationResult(
                payload=None,
                error=f"Task timed out after {self._config.timeout} seconds",
                duration_ms=duration_ms,
                request_id=context.aws_request_id,
            )

        duration_ms = (time.monotonic() - start) * 1000
        return self._parse_result(result, duration_ms, context.aws_request_id)

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
        runtime = self._config.runtime
        if runtime.startswith("python"):
            return ["python3", "/var/bootstrap/python_bootstrap.py"]
        return ["node", "/var/bootstrap/invoker.js"]

    @staticmethod
    def _rewrite_localhost(value: str) -> str:
        """Replace ``127.0.0.1`` and ``localhost`` with ``host.docker.internal``."""
        return value.replace("127.0.0.1", "host.docker.internal").replace(
            "localhost", "host.docker.internal"
        )

    async def _run_exec(
        self, cmd: list[str], env_vars: list[str], event_json: str
    ) -> str:
        """Run ``docker exec`` inside the warm container and return stdout."""
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(
            None, self._run_exec_sync, cmd, env_vars, event_json
        )

    def _run_exec_sync(
        self, cmd: list[str], env_vars: list[str], event_json: str
    ) -> str:
        """Synchronous docker exec using the low-level API for stdin support."""
        api = self._client.api
        exec_id = api.exec_create(
            self._container.id,
            cmd,
            stdin=True,
            stdout=True,
            stderr=True,
            environment=env_vars,
        )
        sock = api.exec_start(exec_id, socket=True, demux=False)

        # Send event JSON to stdin, then close the write side.
        sock._sock.sendall(event_json.encode())
        sock._sock.shutdown(1)  # SHUT_WR

        # Read all output.
        chunks = []
        while True:
            data = sock._sock.recv(4096)
            if not data:
                break
            chunks.append(data)
        sock.close()

        raw = b"".join(chunks)

        # Docker may prefix output with a stream header (8 bytes per frame).
        # Strip any framing to get clean JSON.
        return self._strip_docker_stream_framing(raw).decode(errors="replace")

    @staticmethod
    def _strip_docker_stream_framing(data: bytes) -> bytes:
        """Strip Docker multiplexed stream headers if present.

        Docker's attach/exec protocol prepends an 8-byte header to each
        frame: 1 byte stream type, 3 bytes padding, 4 bytes payload length.
        """
        if len(data) < 8:
            return data
        # Check if first byte looks like a stream type marker (0=stdin, 1=stdout, 2=stderr)
        if data[0] in (0, 1, 2) and data[1:4] == b"\x00\x00\x00":
            result = bytearray()
            offset = 0
            while offset + 8 <= len(data):
                payload_len = int.from_bytes(data[offset + 4 : offset + 8], "big")
                frame_end = offset + 8 + payload_len
                if frame_end > len(data):
                    # Incomplete frame — take what's left
                    result.extend(data[offset + 8 :])
                    break
                result.extend(data[offset + 8 : frame_end])
                offset = frame_end
            return bytes(result)
        return data

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
            error_message = (
                err.get("errorMessage", str(err)) if isinstance(err, dict) else str(err)
            )
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
