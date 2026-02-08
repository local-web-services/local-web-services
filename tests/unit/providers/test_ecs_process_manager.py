"""Tests for ldk.providers.ecs.process_manager."""

from __future__ import annotations

import asyncio
import signal
from unittest.mock import AsyncMock, MagicMock, patch

from ldk.providers.ecs.process_manager import ManagedProcess, ProcessConfig

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


class TestProcessConfig:
    def test_defaults(self) -> None:
        cfg = ProcessConfig(service_name="svc", command=["echo", "hi"])
        assert cfg.grace_period == 10.0
        assert cfg.environment == {}
        assert cfg.working_dir is None

    def test_custom_values(self) -> None:
        cfg = _make_config()
        assert cfg.service_name == "web-api"
        assert cfg.command == ["python", "app.py"]
        assert cfg.environment == {"PORT": "8080"}


# ---------------------------------------------------------------------------
# ManagedProcess lifecycle tests
# ---------------------------------------------------------------------------


class TestManagedProcessLifecycle:
    @patch("asyncio.create_subprocess_exec")
    async def test_start_spawns_subprocess(self, mock_exec: AsyncMock) -> None:
        proc = _mock_process()
        mock_exec.return_value = proc

        mp = ManagedProcess(_make_config())
        await mp.start()

        assert mp.is_running is True
        assert mp.pid == 1234
        mock_exec.assert_called_once()
        call_kwargs = mock_exec.call_args.kwargs
        assert call_kwargs["env"]["PORT"] == "8080"
        assert call_kwargs["cwd"] == "/tmp/app"

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_sends_sigterm(self, mock_exec: AsyncMock) -> None:
        proc = _mock_process()
        mock_exec.return_value = proc

        mp = ManagedProcess(_make_config())
        await mp.start()
        await mp.stop()

        proc.send_signal.assert_called_with(signal.SIGTERM)
        assert mp.is_running is False

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_sends_sigkill_after_grace(self, mock_exec: AsyncMock) -> None:
        proc = _mock_process()
        # First wait() call (inside wait_for) should hang so that wait_for
        # raises TimeoutError.  After kill(), the second wait() succeeds.
        call_count = 0

        async def _wait_side_effect() -> int:
            nonlocal call_count
            call_count += 1
            if call_count == 1:
                await asyncio.sleep(100)  # hang to trigger timeout
            return 0

        proc.wait = _wait_side_effect
        mock_exec.return_value = proc

        cfg = _make_config(grace_period=0.01)
        mp = ManagedProcess(cfg)
        await mp.start()
        await mp.stop()

        proc.kill.assert_called_once()

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_noop_when_already_exited(self, mock_exec: AsyncMock) -> None:
        proc = _mock_process(returncode=0)
        mock_exec.return_value = proc

        mp = ManagedProcess(_make_config())
        await mp.start()
        await mp.stop()

        proc.send_signal.assert_not_called()
        assert mp.is_running is False

    async def test_is_running_false_before_start(self) -> None:
        mp = ManagedProcess(_make_config())
        assert mp.is_running is False

    async def test_pid_none_before_start(self) -> None:
        mp = ManagedProcess(_make_config())
        assert mp.pid is None


# ---------------------------------------------------------------------------
# Stream tests
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
        proc = _mock_process()
        proc.wait = AsyncMock(return_value=42)
        mock_exec.return_value = proc

        mp = ManagedProcess(_make_config())
        await mp.start()
        code = await mp.wait()
        assert code == 42
        assert mp.is_running is False

    async def test_wait_without_start_returns_minus_one(self) -> None:
        mp = ManagedProcess(_make_config())
        code = await mp.wait()
        assert code == -1


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
