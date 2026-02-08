"""Tests for ldk.providers.lambda_runtime.python (P1-01, P1-02, P1-04)."""

from __future__ import annotations

import asyncio
import json
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from ldk.interfaces import (
    ComputeConfig,
    InvocationResult,
    LambdaContext,
    ProviderStartError,
    ProviderStatus,
)
from ldk.providers.lambda_runtime.python import PythonCompute

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_config(**overrides) -> ComputeConfig:
    defaults = dict(
        function_name="my-func",
        handler="handler.main",
        runtime="python3.11",
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


class TestPythonComputeLifecycle:
    """Provider lifecycle: start / stop / health_check / name."""

    def test_name_property(self) -> None:
        provider = PythonCompute(_make_config(), sdk_env={})
        assert provider.name == "lambda:my-func"

    @patch("shutil.which", return_value="/usr/bin/python3")
    async def test_start_sets_running(self, _which: MagicMock) -> None:
        provider = PythonCompute(_make_config(), sdk_env={})
        await provider.start()
        assert await provider.health_check() is True

    @patch("shutil.which", return_value=None)
    async def test_start_raises_when_python3_missing(self, _which: MagicMock) -> None:
        provider = PythonCompute(_make_config(), sdk_env={})
        with pytest.raises(ProviderStartError, match="Python 3 runtime not found"):
            await provider.start()
        assert await provider.health_check() is False

    async def test_stop_sets_stopped(self) -> None:
        provider = PythonCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING
        await provider.stop()
        assert await provider.health_check() is False

    async def test_initial_status_is_stopped(self) -> None:
        provider = PythonCompute(_make_config(), sdk_env={})
        assert await provider.health_check() is False


# ---------------------------------------------------------------------------
# Invocation tests
# ---------------------------------------------------------------------------


class TestPythonComputeInvoke:
    """invoke() success, error, and timeout scenarios."""

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_success(self, mock_exec: AsyncMock) -> None:
        """Successful invocation returns the handler result as payload."""
        success_output = json.dumps({"result": {"statusCode": 200, "body": "ok"}})
        mock_exec.return_value = _mock_process(success_output)

        provider = PythonCompute(_make_config(), sdk_env={})
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
                    "errorMessage": "name 'undefined_var' is not defined",
                    "errorType": "NameError",
                }
            }
        )
        mock_exec.return_value = _mock_process(error_output, returncode=1)

        provider = PythonCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.payload is None
        assert result.error == "name 'undefined_var' is not defined"
        assert result.request_id == "req-abc-123"

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_timeout_kills_process(self, mock_exec: AsyncMock) -> None:
        """When the subprocess exceeds the timeout, the process is killed."""

        async def hang(*args, **kwargs):
            await asyncio.sleep(3600)
            return (b"", b"")

        proc = AsyncMock()
        proc.communicate = hang
        proc.kill = MagicMock()
        mock_exec.return_value = proc

        config = _make_config(timeout=0.05)
        provider = PythonCompute(config, sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.payload is None
        assert "timed out" in result.error
        assert result.request_id == "req-abc-123"

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_bad_json_output(self, mock_exec: AsyncMock) -> None:
        """Non-JSON stdout is treated as an error."""
        mock_exec.return_value = _mock_process("this is not json")

        provider = PythonCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.payload is None
        assert "Failed to parse" in result.error

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_null_result(self, mock_exec: AsyncMock) -> None:
        """Handler returning None should produce a result with None payload."""
        success_output = json.dumps({"result": None})
        mock_exec.return_value = _mock_process(success_output)

        provider = PythonCompute(_make_config(), sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({}, _make_context())

        assert result.payload is None
        assert result.error is None

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_timeout_message_format(self, mock_exec: AsyncMock) -> None:
        """Timeout error message should include the timeout value with 2 decimal places."""

        async def hang(*args, **kwargs):
            await asyncio.sleep(3600)
            return (b"", b"")

        proc = AsyncMock()
        proc.communicate = hang
        proc.kill = MagicMock()
        mock_exec.return_value = proc

        config = _make_config(timeout=5)
        provider = PythonCompute(config, sdk_env={})
        provider._status = ProviderStatus.RUNNING

        result = await provider.invoke({"key": "value"}, _make_context())

        assert result.error == "Task timed out after 5.00 seconds"


# ---------------------------------------------------------------------------
# Environment variable tests
# ---------------------------------------------------------------------------


class TestPythonComputeEnvironment:
    """Environment variables are correctly built for the subprocess."""

    def test_env_merges_all_sources(self) -> None:
        """os.environ + config.environment + sdk_env are merged."""
        config = _make_config(environment={"APP_ENV": "test"})
        sdk_env = {"AWS_ENDPOINT_URL_DYNAMODB": "http://localhost:4566"}
        provider = PythonCompute(config, sdk_env=sdk_env)

        context = _make_context()
        env = provider._build_env(context)

        assert "PATH" in env
        assert env["APP_ENV"] == "test"
        assert env["AWS_ENDPOINT_URL_DYNAMODB"] == "http://localhost:4566"

    def test_env_sets_ldk_vars(self) -> None:
        """LDK-specific env vars are set from config and context."""
        config = _make_config()
        provider = PythonCompute(config, sdk_env={})

        context = _make_context()
        env = provider._build_env(context)

        assert env["LDK_HANDLER"] == "handler.main"
        assert env["LDK_CODE_PATH"] == "/tmp/code"
        assert env["LDK_REQUEST_ID"] == "req-abc-123"
        assert env["LDK_FUNCTION_ARN"] == ("arn:aws:lambda:us-east-1:123456789012:function:my-func")
        assert env["LDK_TIMEOUT"] == "30"
        assert env["AWS_LAMBDA_FUNCTION_NAME"] == "my-func"
        assert env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] == "128"

    def test_sdk_env_overrides_config_env(self) -> None:
        """sdk_env takes precedence over config.environment for the same key."""
        config = _make_config(environment={"SHARED_KEY": "from-config"})
        sdk_env = {"SHARED_KEY": "from-sdk"}
        provider = PythonCompute(config, sdk_env=sdk_env)

        context = _make_context()
        env = provider._build_env(context)

        assert env["SHARED_KEY"] == "from-sdk"

    def test_debug_port_env_var_when_set(self) -> None:
        """LDK_DEBUG_PORT should be set when debug_port is provided."""
        config = _make_config()
        provider = PythonCompute(config, sdk_env={}, debug_port=5678)

        context = _make_context()
        env = provider._build_env(context)

        assert env["LDK_DEBUG_PORT"] == "5678"

    def test_no_debug_port_env_var_by_default(self) -> None:
        """LDK_DEBUG_PORT should not be set when debug_port is None."""
        config = _make_config()
        provider = PythonCompute(config, sdk_env={})

        context = _make_context()
        env = provider._build_env(context)

        assert "LDK_DEBUG_PORT" not in env

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_passes_env_to_subprocess(self, mock_exec: AsyncMock) -> None:
        """The env dict built by _build_env is passed to the subprocess."""
        success_output = json.dumps({"result": None})
        mock_exec.return_value = _mock_process(success_output)

        sdk_env = {"SDK_VAR": "sdk-value"}
        config = _make_config(environment={"CFG_VAR": "cfg-value"})
        provider = PythonCompute(config, sdk_env=sdk_env)
        provider._status = ProviderStatus.RUNNING

        await provider.invoke({"key": "value"}, _make_context())

        call_kwargs = mock_exec.call_args.kwargs
        env_passed = call_kwargs["env"]
        assert env_passed["SDK_VAR"] == "sdk-value"
        assert env_passed["CFG_VAR"] == "cfg-value"
        assert env_passed["LDK_HANDLER"] == "handler.main"
