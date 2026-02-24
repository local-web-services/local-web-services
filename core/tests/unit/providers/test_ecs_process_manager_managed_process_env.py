"""Tests for ldk.providers.ecs.process_manager."""

from __future__ import annotations

import asyncio
import signal
from unittest.mock import AsyncMock, MagicMock, patch

from lws.providers.ecs.process_manager import ManagedProcess, ProcessConfig

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_config(**overrides: object) -> ProcessConfig:
    defaults: dict = dict(
        service_name="web-api",
        command=["python", "app.py"],
        environment={"PORT": "8080"},
        working_dir="/tmp/app",
        grace_period=5.0,
    )
    defaults.update(overrides)
    return ProcessConfig(**defaults)


def _mock_process(
    pid: int = 1234,
    returncode: int | None = None,
) -> AsyncMock:
    """Create a mock asyncio.subprocess.Process."""
    proc = AsyncMock(spec=asyncio.subprocess.Process)
    proc.pid = pid
    proc.returncode = returncode
    proc.stdout = AsyncMock(spec=asyncio.StreamReader)
    proc.stderr = AsyncMock(spec=asyncio.StreamReader)
    # readline returns empty bytes to signal EOF immediately
    proc.stdout.readline = AsyncMock(return_value=b"")
    proc.stderr.readline = AsyncMock(return_value=b"")
    proc.wait = AsyncMock(return_value=0)
    proc.send_signal = MagicMock()
    proc.kill = MagicMock()
    return proc


# ---------------------------------------------------------------------------
# ProcessConfig tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ManagedProcess lifecycle tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Stream tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Environment tests
# ---------------------------------------------------------------------------


class TestManagedProcessEnv:
    @patch("asyncio.create_subprocess_exec")
    async def test_env_merges_os_and_config(self, mock_exec: AsyncMock) -> None:
        proc = _mock_process()
        mock_exec.return_value = proc

        mp = ManagedProcess(_make_config(environment={"MY_VAR": "my_val"}))
        await mp.start()

        call_kwargs = mock_exec.call_args.kwargs
        env = call_kwargs["env"]
        # OS env should be present
        assert "PATH" in env
        # Config env should be present
        assert env["MY_VAR"] == "my_val"

    def test_send_signal_handles_process_not_found(self) -> None:
        mp = ManagedProcess(_make_config())
        # Should not raise when _process is None
        mp._send_signal(signal.SIGTERM)
