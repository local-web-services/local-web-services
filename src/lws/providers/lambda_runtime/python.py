"""Python Lambda runtime provider extending SubprocessCompute."""

from __future__ import annotations

import asyncio
import shutil
import signal
from pathlib import Path

from lws.interfaces import (
    ComputeConfig,
    InvocationResult,
    LambdaContext,
    ProviderStartError,
    ProviderStatus,
)
from lws.providers.lambda_runtime.compute_base import SubprocessCompute

_BOOTSTRAP_PY = Path(__file__).parent / "python_bootstrap.py"


class PythonCompute(SubprocessCompute):
    """SubprocessCompute implementation that runs Lambda handlers via Python subprocess.

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
        super().__init__(config, sdk_env)
        self._debug_port = debug_port

    # -- Provider lifecycle ---------------------------------------------------

    async def start(self) -> None:
        """Verify Python 3 is available and mark provider as RUNNING."""
        python_path = shutil.which("python3")
        if python_path is None:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError("Python 3 runtime not found. Ensure 'python3' is on the PATH.")
        self._status = ProviderStatus.RUNNING

    # -- Invocation -----------------------------------------------------------

    def _timeout_result(self, duration_ms: float, request_id: str) -> InvocationResult:
        """Build a timeout error result with 2-decimal-place formatting."""
        timeout_secs = f"{self._config.timeout:.2f}"
        return InvocationResult(
            payload=None,
            error=f"Task timed out after {timeout_secs} seconds",
            duration_ms=duration_ms,
            request_id=request_id,
        )

    # -- Internal helpers -----------------------------------------------------

    def _build_env(self, context: LambdaContext) -> dict[str, str]:
        """Extend base env with LDK_TIMEOUT and optional LDK_DEBUG_PORT."""
        env = super()._build_env(context)
        env["LDK_TIMEOUT"] = str(self._config.timeout)
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
