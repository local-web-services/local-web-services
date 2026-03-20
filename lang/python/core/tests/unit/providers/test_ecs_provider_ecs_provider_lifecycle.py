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


def _fake_process() -> AsyncMock:
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
        expected_name = "ecs"
        actual_name = provider.name
        assert actual_name == expected_name, f"Expected {expected_name!r} but got {actual_name!r}"

    async def test_initial_status_stopped(self) -> None:
        provider = EcsProvider(services=[])
        assert await provider.health_check() is False, "Expected value to be truthy"

    @patch("asyncio.create_subprocess_exec")
    async def test_start_sets_running(self, fake_exec: AsyncMock) -> None:
        fake_exec.return_value = _fake_process()
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        await provider.start()
        assert provider._status == ProviderStatus.RUNNING, f"Expected {ProviderStatus.RUNNING!r} but got {provider._status!r}"

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_sets_stopped(self, fake_exec: AsyncMock) -> None:
        fake_exec.return_value = _fake_process()
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        await provider.start()
        await provider.stop()
        assert provider._status == ProviderStatus.STOPPED, f"Expected {ProviderStatus.STOPPED!r} but got {provider._status!r}"

    @patch("asyncio.create_subprocess_exec")
    async def test_start_registers_service(self, fake_exec: AsyncMock) -> None:
        fake_exec.return_value = _fake_process()
        registry = ServiceRegistry()
        svc = _make_service()
        provider = EcsProvider(services=[svc], registry=registry)

        await provider.start()
        ep = registry.lookup("web-api")
        assert ep is not None, "Expected value to be set but was None"
        assert ep.port == 8080, f"Expected {8080!r} but got {ep.port!r}"
        await provider.stop()

    @patch("asyncio.create_subprocess_exec")
    async def test_stop_deregisters_service(self, fake_exec: AsyncMock) -> None:
        fake_exec.return_value = _fake_process()
        registry = ServiceRegistry()
        svc = _make_service()
        provider = EcsProvider(services=[svc], registry=registry)

        await provider.start()
        await provider.stop()
        assert registry.lookup("web-api") is None, f'Expected None but got {registry.lookup("web-api")!r}'

    @patch("asyncio.create_subprocess_exec", side_effect=OSError("spawn failed"))
    async def test_start_error_sets_error_status(self, fake_exec: AsyncMock) -> None:
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        with pytest.raises(ProviderStartError, match="Failed to start"):
            await provider.start()
        assert provider._status == ProviderStatus.ERROR, f"Expected {ProviderStatus.ERROR!r} but got {provider._status!r}"
