"""Tests for ldk.providers.ecs.provider."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from lws.interfaces.provider import ProviderStartError, ProviderStatus
from lws.providers.ecs.discovery import ServiceRegistry
from lws.providers.ecs.provider import (
    ContainerDefinition,
    EcsProvider,
    ServiceDefinition,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_container(**overrides: object) -> ContainerDefinition:
    defaults: dict = dict(
        name="app",
        image="myimage:latest",
        command=["python", "server.py"],
        entry_point=[],
        environment={"PORT": "8080"},
        port_mappings=[{"containerPort": 8080, "hostPort": 8080}],
        health_check=None,
    )
    defaults.update(overrides)
    return ContainerDefinition(**defaults)


def _make_service(**overrides: object) -> ServiceDefinition:
    defaults: dict = dict(
        service_name="web-api",
        containers=[_make_container()],
        local_command=None,
        desired_count=1,
        watch_path=None,
    )
    defaults.update(overrides)
    return ServiceDefinition(**defaults)


def _mock_process() -> AsyncMock:
    proc = AsyncMock()
    proc.pid = 1234
    proc.returncode = None
    proc.stdout = AsyncMock()
    proc.stderr = AsyncMock()
    proc.stdout.readline = AsyncMock(return_value=b"")
    proc.stderr.readline = AsyncMock(return_value=b"")
    proc.wait = AsyncMock(return_value=0)
    proc.send_signal = MagicMock()
    proc.kill = MagicMock()
    return proc


# ---------------------------------------------------------------------------
# ContainerDefinition tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ServiceDefinition tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# EcsProvider lifecycle tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Health check integration
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Restart tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Command resolution tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Environment merging tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Health path extraction tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# parse_task_definition tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# _parse_env_list tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# parse_ecs_resources tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Port extraction tests
# ---------------------------------------------------------------------------


class TestEcsProviderLifecycle:
    def test_name(self) -> None:
        provider = EcsProvider(services=[])
        assert provider.name == "ecs"

    async def test_initial_status_stopped(self) -> None:
        provider = EcsProvider(services=[])
        assert await provider.health_check() is False

    @patch("asyncio.create_subprocess_exec")
    async def test_start_sets_running(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        await provider.start()
        assert provider._status == ProviderStatus.RUNNING

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_sets_stopped(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        await provider.start()
        await provider.stop()
        assert provider._status == ProviderStatus.STOPPED

    @patch("asyncio.create_subprocess_exec")
    async def test_start_registers_service(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        registry = ServiceRegistry()
        svc = _make_service()
        provider = EcsProvider(services=[svc], registry=registry)

        await provider.start()
        ep = registry.lookup("web-api")
        assert ep is not None
        assert ep.port == 8080
        await provider.stop()

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_deregisters_service(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        registry = ServiceRegistry()
        svc = _make_service()
        provider = EcsProvider(services=[svc], registry=registry)

        await provider.start()
        await provider.stop()
        assert registry.lookup("web-api") is None

    @patch("asyncio.create_subprocess_exec", side_effect=OSError("spawn failed"))
    async def test_start_error_sets_error_status(self, mock_exec: AsyncMock) -> None:
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        with pytest.raises(ProviderStartError, match="Failed to start"):
            await provider.start()
        assert provider._status == ProviderStatus.ERROR
