"""Tests for ldk.providers.lambda_runtime.nodejs (P0-13)."""

from __future__ import annotations

import json
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

from lws.interfaces import (
    ComputeConfig,
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


class TestNodeJsComputeEnvironment:
    """Environment variables are correctly built for the subprocess."""

    def test_env_merges_all_sources(self) -> None:
        """os.environ + config.environment + sdk_env are merged."""
        expected_app_env = "test"
        expected_dynamodb_url = "http://localhost:4566"
        config = _make_config(environment={"APP_ENV": expected_app_env})
        sdk_env = {"AWS_ENDPOINT_URL_DYNAMODB": expected_dynamodb_url}
        provider = NodeJsCompute(config, sdk_env=sdk_env)

        context = _make_context()
        env = provider._build_env(context)

        # Assert
        # os.environ should be present (spot-check PATH)
        assert "PATH" in env
        # config.environment
        assert env["APP_ENV"] == expected_app_env
        # sdk_env
        assert env["AWS_ENDPOINT_URL_DYNAMODB"] == expected_dynamodb_url

    def test_env_sets_ldk_vars(self) -> None:
        """LDK-specific env vars are set from config and context."""
        config = _make_config()
        provider = NodeJsCompute(config, sdk_env={})

        context = _make_context()
        env = provider._build_env(context)

        # Assert
        expected_handler = "index.handler"
        expected_code_path = "/tmp/code"
        expected_request_id = "req-abc-123"
        expected_function_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-func"
        expected_function_name = "my-func"
        expected_memory_size = "128"
        assert env["LDK_HANDLER"] == expected_handler
        assert env["LDK_CODE_PATH"] == expected_code_path
        assert env["LDK_REQUEST_ID"] == expected_request_id
        assert env["LDK_FUNCTION_ARN"] == expected_function_arn
        assert env["AWS_LAMBDA_FUNCTION_NAME"] == expected_function_name
        assert env["AWS_LAMBDA_FUNCTION_MEMORY_SIZE"] == expected_memory_size

    def test_sdk_env_overrides_config_env(self) -> None:
        """sdk_env takes precedence over config.environment for the same key."""
        config = _make_config(environment={"SHARED_KEY": "from-config"})
        expected_value = "from-sdk"
        sdk_env = {"SHARED_KEY": expected_value}
        provider = NodeJsCompute(config, sdk_env=sdk_env)

        context = _make_context()
        env = provider._build_env(context)

        # Assert
        assert env["SHARED_KEY"] == expected_value

    @patch("asyncio.create_subprocess_exec")
    async def test_invoke_passes_env_to_subprocess(self, mock_exec: AsyncMock) -> None:
        """The env dict built by _build_env is passed to the subprocess."""
        success_output = json.dumps({"result": None})
        mock_exec.return_value = _mock_process(success_output)

        sdk_env = {"SDK_VAR": "sdk-value"}
        config = _make_config(environment={"CFG_VAR": "cfg-value"})
        provider = NodeJsCompute(config, sdk_env=sdk_env)
        provider._status = ProviderStatus.RUNNING

        await provider.invoke({"key": "value"}, _make_context())

        # Assert
        expected_sdk_var = "sdk-value"
        expected_cfg_var = "cfg-value"
        expected_handler = "index.handler"
        call_kwargs = mock_exec.call_args.kwargs
        env_passed = call_kwargs["env"]
        assert env_passed["SDK_VAR"] == expected_sdk_var
        assert env_passed["CFG_VAR"] == expected_cfg_var
        assert env_passed["LDK_HANDLER"] == expected_handler
