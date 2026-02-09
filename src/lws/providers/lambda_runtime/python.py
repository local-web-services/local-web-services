"""Python Lambda runtime provider implementing ICompute."""

from __future__ import annotations

import asyncio
import json
import os
import shutil
import signal
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

_BOOTSTRAP_PY = Path(__file__).parent / "python_bootstrap.py"


class PythonCompute(ICompute):
    """ICompute implementation that runs Lambda handlers via Python subprocess.

    Each invocation spawns ``python3 python_bootstrap.py``, passing the event
    payload over stdin and reading the result from stdout.

    Supports optional debugpy integration: when ``debug_port`` is set, the
    ``LDK_DEBUG_PORT`` environment variable is forwarded to the bootstrap so it
    can attach a remote debugger.
    """

    def __init__(
        self,
        config: ComputeConfig,
        sdk_env: dict[str, str],
        debug_port: int | None = None,
    ) -> None:
        self._config = config
        self._sdk_env = sdk_env
        self._debug_port = debug_port
        self._status = ProviderStatus.STOPPED

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        """Return the unique name of this provider."""
        return f"lambda:{self._config.function_name}"

    async def start(self) -> None:
        """Verify Python 3 is available and mark provider as RUNNING."""
        python_path = shutil.which("python3")
        if python_path is None:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError("Python 3 runtime not found. Ensure 'python3' is on the PATH.")
        self._status = ProviderStatus.RUNNING

    async def stop(self) -> None:
        """Mark provider as STOPPED."""
        self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        """Return True when the provider status is RUNNING."""
        return self._status is ProviderStatus.RUNNING

    # -- Invocation -----------------------------------------------------------

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        """Invoke a Python Lambda handler in a subprocess.

        The subprocess receives the event via stdin and writes the result (or
        error) as JSON to stdout.  Timeout enforcement sends SIGTERM, waits 1s,
        then SIGKILL.
        """
        env = self._build_env(context)
        event_json = json.dumps(event)

        start = time.monotonic()
        try:
            result = await asyncio.wait_for(
                self._run_subprocess(env, event_json),
                timeout=self._config.timeout,
            )
        except TimeoutError:
            duration_ms = (time.monotonic() - start) * 1000
            timeout_secs = f"{self._config.timeout:.2f}"
            return InvocationResult(
                payload=None,
                error=f"Task timed out after {timeout_secs} seconds",
                duration_ms=duration_ms,
                request_id=context.aws_request_id,
            )

        duration_ms = (time.monotonic() - start) * 1000
        return self._parse_result(result, duration_ms, context.aws_request_id)

    # -- Internal helpers -----------------------------------------------------

    def _build_env(self, context: LambdaContext) -> dict[str, str]:
        """Merge os.environ, config.environment, and sdk_env into one dict."""
        env: dict[str, str] = {}
        env.update(os.environ)
        env.update(self._config.environment)
        env.update(self._sdk_env)
        env["LDK_HANDLER"] = self._config.handler
        env["LDK_CODE_PATH"] = str(self._config.code_path)
        env["LDK_REQUEST_ID"] = context.aws_request_id
        env["LDK_FUNCTION_ARN"] = context.invoked_function_arn
        env["LDK_TIMEOUT"] = str(self._config.timeout)
        env["AWS_LAMBDA_FUNCTION_NAME"] = self._config.function_name
        env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] = str(self._config.memory_size)
        if self._debug_port is not None:
            env["LDK_DEBUG_PORT"] = str(self._debug_port)
        return env

    async def _run_subprocess(self, env: dict[str, str], event_json: str) -> str:
        """Spawn ``python3 python_bootstrap.py`` and return its stdout."""
        process = await asyncio.create_subprocess_exec(
            "python3",
            str(_BOOTSTRAP_PY),
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=env,
        )
        try:
            stdout, _stderr = await process.communicate(input=event_json.encode())
        except asyncio.CancelledError:
            await self._terminate_process(process)
            raise
        return stdout.decode()

    @staticmethod
    async def _terminate_process(process: asyncio.subprocess.Process) -> None:
        """Send SIGTERM, wait 1s, then SIGKILL if process is still alive."""
        try:
            process.send_signal(signal.SIGTERM)
        except ProcessLookupError:
            return
        try:
            await asyncio.wait_for(process.wait(), timeout=1.0)
        except TimeoutError:
            process.kill()

    @staticmethod
    def _parse_result(raw: str, duration_ms: float, request_id: str) -> InvocationResult:
        """Parse the JSON emitted by python_bootstrap.py into an InvocationResult."""
        try:
            data = json.loads(raw)
        except json.JSONDecodeError:
            return InvocationResult(
                payload=None,
                error=f"Failed to parse subprocess output: {raw!r}",
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
