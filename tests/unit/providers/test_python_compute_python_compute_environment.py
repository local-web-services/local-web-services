"""Tests for ldk.providers.lambda_runtime.python (P1-01, P1-02, P1-04)."""

from __future__ import annotations

import json
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

from lws.interfaces import (
    ComputeConfig,
    LambdaContext,
    ProviderStatus,
)
from lws.providers.lambda_runtime.python import PythonCompute

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


# ---------------------------------------------------------------------------
# Invocation tests
# ---------------------------------------------------------------------------


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
