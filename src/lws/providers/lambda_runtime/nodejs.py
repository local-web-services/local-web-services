"""Node.js Lambda runtime provider implementing ICompute."""

from __future__ import annotations

import asyncio
import json
import os
import shutil
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

_INVOKER_JS = Path(__file__).parent / "invoker.js"


class NodeJsCompute(ICompute):
    """ICompute implementation that runs Lambda handlers via Node.js subprocess.

    Each invocation spawns ``node invoker.js``, passing the event payload over
    stdin and reading the result from stdout.
    """

    def __init__(self, config: ComputeConfig, sdk_env: dict[str, str]) -> None:
        self._config = config
        self._sdk_env = sdk_env
        self._status = ProviderStatus.STOPPED

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        """Return the unique name of this provider."""
        return f"lambda:{self._config.function_name}"

    async def start(self) -> None:
        """Verify Node.js is available and mark provider as RUNNING."""
        node_path = shutil.which("node")
        if node_path is None:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError("Node.js runtime not found. Ensure 'node' is on the PATH.")
        self._status = ProviderStatus.RUNNING

    async def stop(self) -> None:
        """Mark provider as STOPPED."""
        self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        """Return True when the provider status is RUNNING."""
        return self._status is ProviderStatus.RUNNING

    # -- Invocation -----------------------------------------------------------

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        """Invoke a Node.js Lambda handler in a subprocess.

        The subprocess receives the event via stdin and writes the result (or
        error) as JSON to stdout.
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
            return InvocationResult(
                payload=None,
                error="Task timed out after " f"{self._config.timeout} seconds",
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
        env["AWS_LAMBDA_FUNCTION_NAME"] = self._config.function_name
        env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] = str(self._config.memory_size)
        return env

    async def _run_subprocess(self, env: dict[str, str], event_json: str) -> str:
        """Spawn ``node invoker.js`` and return its stdout."""
        process = await asyncio.create_subprocess_exec(
            "node",
            str(_INVOKER_JS),
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=env,
        )
        try:
            stdout, _stderr = await process.communicate(input=event_json.encode())
        except asyncio.CancelledError:
            process.kill()
            raise
        return stdout.decode()

    @staticmethod
    def _parse_result(raw: str, duration_ms: float, request_id: str) -> InvocationResult:
        """Parse the JSON emitted by invoker.js into an InvocationResult."""
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
