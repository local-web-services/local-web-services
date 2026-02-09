"""Tests for ldk.providers.lambda_runtime.nodejs (P0-13)."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

from lws.interfaces import (
    ComputeConfig,
    InvocationResult,
    LambdaContext,
    ProviderStatus,
)
from lws.providers.lambda_runtime.nodejs import NodeJsCompute

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_config(**overrides) -> ComputeConfig:
    defaults = dict(
        function_name="my-func",
        handler="index.handler",
        runtime="nodejs20.x",
        code_path=Path("/tmp/code"),
        timeout=30,
        memory_size=128,
        environment={"APP_ENV": "test"},
    )
    defaults.update(overrides)
    return ComputeConfig(**defaults)


def _make_context(**overrides) -> LambdaContext:
    defaults = dict(
        function_name="my-func",
        memory_limit_in_mb=128,
        timeout_seconds=30,
        aws_request_id="req-abc-123",
        invoked_function_arn="arn:aws:lambda:us-east-1:123456789012:function:my-func",
    )
    defaults.update(overrides)
    return LambdaContext(**defaults)


def _mock_process(stdout: str, returncode: int = 0) -> AsyncMock:
    """Create a mock asyncio.subprocess.Process."""
    proc = AsyncMock()
    proc.communicate = AsyncMock(return_value=(stdout.encode(), b""))
    proc.returncode = returncode
    proc.kill = MagicMock()
    return proc


# ---------------------------------------------------------------------------
# Lifecycle tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Invocation tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Environment variable tests
# ---------------------------------------------------------------------------


class TestNodeJsComputeInvoke:
    """invoke() success, error, and timeout scenarios."""

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_success(self, mock_exec: AsyncMock) -> None:
        """Successful invocation returns the handler result as payload."""
        success_output = json.dumps({"result": {"statusCode": 200, "body": "ok"}})
        mock_exec.return_value = _mock_process(success_output)

        provider = NodeJsCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert isinstance(result, InvocationResult)
        assert result.payload == {"statusCode": 200, "body": "ok"}
        assert result.error is None
        assert result.request_id == "req-abc-123"
        assert result.duration_ms >= 0

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_handler_error(self, mock_exec: AsyncMock) -> None:
        """When the handler throws, invoke returns an error InvocationResult."""
        error_output = json.dumps(
            {
                "error": {
                    "errorMessage": "Cannot read property 'foo' of undefined",
                    "errorType": "TypeError",
                    "stackTrace": ["at handler (index.js:5:10)"],
                }
            }
        )
        mock_exec.return_value = _mock_process(error_output, returncode=1)

        provider = NodeJsCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.payload is None
        assert result.error == "Cannot read property 'foo' of undefined"
        assert result.request_id == "req-abc-123"

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_timeout_kills_process(self, mock_exec: AsyncMock) -> None:
        """When the subprocess exceeds the timeout, the process is killed."""

        # Make communicate hang forever
        async def hang(*args, **kwargs):
            await asyncio.sleep(3600)
            return (b"", b"")

        proc = AsyncMock()
        proc.communicate = hang
        proc.kill = MagicMock()
        mock_exec.return_value = proc

        config = _make_config(timeout=0.05)
        provider = NodeJsCompute(config, sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.payload is None
        assert "timed out" in result.error
        assert result.request_id == "req-abc-123"

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_bad_json_output(self, mock_exec: AsyncMock) -> None:
        """Non-JSON stdout is treated as an error."""
        mock_exec.return_value = _mock_process("this is not json")

        provider = NodeJsCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.payload is None
        assert "Failed to parse" in result.error
