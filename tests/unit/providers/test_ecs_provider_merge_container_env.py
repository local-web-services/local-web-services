"""Tests for ldk.providers.ecs.provider."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock

from ldk.providers.ecs.provider import (
    ContainerDefinition,
    ServiceDefinition,
    _merge_container_env,
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


class TestMergeContainerEnv:
    def test_single_container(self) -> None:
        svc = _make_service()
        env = _merge_container_env(svc)
        assert env["PORT"] == "8080"

    def test_multiple_containers_merged(self) -> None:
        c1 = _make_container(name="app", environment={"A": "1"})
        c2 = _make_container(name="sidecar", environment={"B": "2"})
        svc = _make_service(containers=[c1, c2])
        env = _merge_container_env(svc)
        assert env["A"] == "1"
        assert env["B"] == "2"
