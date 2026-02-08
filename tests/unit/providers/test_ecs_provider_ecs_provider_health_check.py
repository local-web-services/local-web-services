"""Tests for ldk.providers.ecs.provider."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock, patch

from ldk.interfaces.provider import ProviderStatus
from ldk.providers.ecs.provider import (
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


class TestEcsProviderHealthCheck:
    async def test_health_check_true_no_services(self) -> None:
        """Provider with no services (and RUNNING) should be healthy."""
        provider = EcsProvider(services=[])
        provider._status = ProviderStatus.RUNNING
        assert await provider.health_check() is True

    @patch("asyncio.create_subprocess_exec")
    async def test_health_check_delegates_to_checkers(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        container = _make_container(
            health_check={
                "command": ["CMD-SHELL", "curl -f http://localhost:8080/health"],
                "interval": 60,
                "retries": 3,
            }
        )
        svc = _make_service(containers=[container])
        provider = EcsProvider(services=[svc])
        await provider.start()

        # Checker was created
        assert "web-api" in provider._checkers
        await provider.stop()
