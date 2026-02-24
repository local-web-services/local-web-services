"""Tests for ldk.providers.ecs.process_manager."""

from __future__ import annotations

import asyncio
from unittest.fake import AsyncFake, MagicFake

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
) -> AsyncFake:
    """Create a fake asyncio.subprocess.Process."""
    proc = AsyncFake(spec=asyncio.subprocess.Process)
    proc.pid = pid
    proc.returncode = returncode
    proc.stdout = AsyncFake(spec=asyncio.StreamReader)
    proc.stderr = AsyncFake(spec=asyncio.StreamReader)
    # readline returns empty bytes to signal EOF immediately
    proc.stdout.readline = AsyncFake(return_value=b"")
    proc.stderr.readline = AsyncFake(return_value=b"")
    proc.wait = AsyncFake(return_value=0)
    proc.send_signal = MagicFake()
    proc.kill = MagicFake()
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
        assert cfg.grace_period == 10.0
        assert cfg.environment == {}
        assert cfg.working_dir is None

    def test_custom_values(self) -> None:
        cfg = _make_config()
        assert cfg.service_name == "web-api"
        assert cfg.command == ["python", "app.py"]
        assert cfg.environment == {"PORT": "8080"}
