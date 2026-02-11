"""Shared base class for subprocess-based Lambda compute providers."""

from __future__ import annotations

import asyncio
import json
import os
import time

from lws.interfaces import (
    ComputeConfig,
    ICompute,
    InvocationResult,
    LambdaContext,
    ProviderStatus,
)
from lws.providers.lambda_runtime.result_parser import parse_invocation_output


class SubprocessCompute(ICompute):
    """Base class for Lambda compute providers that run handlers via subprocess.

    Subclasses must implement ``_run_subprocess`` and ``_build_env``.
    """

    def __init__(self, config: ComputeConfig, sdk_env: dict[str, str]) -> None:
        self._config = config
        self._sdk_env = sdk_env
        self._status = ProviderStatus.STOPPED

    @property
    def sdk_env(self) -> dict[str, str]:
        """Return the SDK environment variables."""
        return self._sdk_env

    @sdk_env.setter
    def sdk_env(self, value: dict[str, str]) -> None:
        """Set the SDK environment variables."""
        self._sdk_env = value

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        """Return the unique name of this provider."""
        return f"lambda:{self._config.function_name}"

    async def stop(self) -> None:
        """Mark provider as STOPPED."""
        self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        """Return True when the provider status is RUNNING."""
        return self._status is ProviderStatus.RUNNING

    # -- Invocation -----------------------------------------------------------

    async def invoke(self, event: dict, context: LambdaContext) -> InvocationResult:
        """Invoke a Lambda handler in a subprocess with timeout enforcement."""
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
            return self._timeout_result(duration_ms, context.aws_request_id)

        duration_ms = (time.monotonic() - start) * 1000
        return parse_invocation_output(result, duration_ms, context.aws_request_id)

    def _timeout_result(self, duration_ms: float, request_id: str) -> InvocationResult:
        """Build a timeout error result."""
        return InvocationResult(
            payload=None,
            error=f"Task timed out after {self._config.timeout} seconds",
            duration_ms=duration_ms,
            request_id=request_id,
        )

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
        """Spawn the subprocess and return its stdout. Must be overridden."""
        raise NotImplementedError

    @staticmethod
    async def _exec_and_communicate(*cmd: str, env: dict[str, str], event_json: str) -> str:
        """Create a subprocess, send event_json on stdin, return stdout."""
        process = await asyncio.create_subprocess_exec(
            *cmd,
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=env,
        )
        stdout, _stderr = await process.communicate(input=event_json.encode())
        return stdout.decode()
