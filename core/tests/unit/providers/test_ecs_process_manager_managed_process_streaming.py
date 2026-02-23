"""Tests for ldk.providers.ecs.process_manager."""

from __future__ import annotations

import asyncio
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


class TestManagedProcessStreaming:
    @patch("asyncio.create_subprocess_exec")
    async def test_stdout_lines_logged(self, mock_exec: AsyncMock) -> None:
        proc = _mock_process()
        lines = [b"hello\n", b"world\n", b""]
        call_count = 0

        async def _readline() -> bytes:
            nonlocal call_count
            idx = call_count
            call_count += 1
            if idx < len(lines):
                return lines[idx]
            return b""

        proc.stdout.readline = _readline
        mock_exec.return_value = proc

        mp = ManagedProcess(_make_config())
        await mp.start()
        # Give stream tasks a tick to read
        await asyncio.sleep(0.05)
        await mp.stop()

    @patch("asyncio.create_subprocess_exec")
    async def test_wait_returns_exit_code(self, mock_exec: AsyncMock) -> None:
        # Arrange
        expected_exit_code = 42
        proc = _mock_process()
        proc.wait = AsyncMock(return_value=expected_exit_code)
        mock_exec.return_value = proc

        # Act
        mp = ManagedProcess(_make_config())
        await mp.start()
        actual_exit_code = await mp.wait()

        # Assert
        assert actual_exit_code == expected_exit_code
        assert mp.is_running is False

    async def test_wait_without_start_returns_minus_one(self) -> None:
        # Act
        mp = ManagedProcess(_make_config())
        actual_code = await mp.wait()

        # Assert
        expected_code = -1
        assert actual_code == expected_code
