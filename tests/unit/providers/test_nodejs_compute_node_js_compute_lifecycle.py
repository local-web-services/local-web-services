"""Tests for ldk.providers.lambda_runtime.nodejs (P0-13)."""

from __future__ import annotations

from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from lws.interfaces import (
    ComputeConfig,
    LambdaContext,
    ProviderStartError,
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


class TestNodeJsComputeLifecycle:
    """Provider lifecycle: start / stop / health_check / name."""

    def test_name_property(self) -> None:
        provider = NodeJsCompute(_make_config(), sdk_env={})
        assert provider.name == "lambda:my-func"

    @patch("shutil.which", return_value="/usr/local/bin/node")
    async def test_start_sets_running(self, _which: MagicMock) -> None:
        provider = NodeJsCompute(_make_config(), sdk_env={})
        await provider.start()
        assert await provider.health_check() is True

    @patch("shutil.which", return_value=None)
    async def test_start_raises_when_node_missing(self, _which: MagicMock) -> None:
        provider = NodeJsCompute(_make_config(), sdk_env={})
        with pytest.raises(ProviderStartError, match="Node.js runtime not found"):
            await provider.start()
        assert await provider.health_check() is False

    async def test_stop_sets_stopped(self) -> None:
        provider = NodeJsCompute(_make_config(), sdk_env={})
        # Manually put it into RUNNING first
        provider._status = ProviderStatus.RUNNING
        await provider.stop()
        assert await provider.health_check() is False

    async def test_initial_status_is_stopped(self) -> None:
        provider = NodeJsCompute(_make_config(), sdk_env={})
        assert await provider.health_check() is False
