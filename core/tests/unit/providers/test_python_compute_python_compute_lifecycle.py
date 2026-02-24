"""Tests for ldk.providers.lambda_runtime.python (P1-01, P1-02, P1-04)."""

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


class TestPythonComputeLifecycle:
    """Provider lifecycle: start / stop / health_check / name."""

    def test_name_property(self) -> None:
        provider = PythonCompute(_make_config(), sdk_env={})

        expected_name = "lambda:my-func"
        actual_name = provider.name
        assert actual_name == expected_name

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
