"""Tests for ldk.providers.ecs.process_manager."""

from __future__ import annotations

import asyncio
from unittest.mock import AsyncMock, MagicMock

from lws.providers.ecs.process_manager import ProcessConfig

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


def _fake_process(
    pid: int = 1234,
    returncode: int | None = None,
) -> AsyncMock:
    """Create a fake asyncio.subprocess.Process."""
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


class TestProcessConfig:
    def test_defaults(self) -> None:
        cfg = ProcessConfig(service_name="svc", command=["echo", "hi"])
        assert cfg.grace_period == 10.0, f"Expected {10.0!r} but got {cfg.grace_period!r}"
        assert cfg.environment == {}, "Expected {0!r} but got {1!r}".format({}, cfg.environment)
        assert cfg.working_dir is None, f"Expected None but got {cfg.working_dir!r}"

    def test_custom_values(self) -> None:
        cfg = _make_config()
        assert cfg.service_name == "web-api", f'Expected {"web-api"!r} but got {cfg.service_name!r}'
        assert cfg.command == ["python", "app.py"], f'Expected {["python", "app.py"]!r} but got {cfg.command!r}'
        assert cfg.environment == {"PORT": "8080"}, "Expected {0!r} but got {1!r}".format({"PORT": "8080"}, cfg.environment)
