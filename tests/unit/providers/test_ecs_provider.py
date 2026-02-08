"""Tests for ldk.providers.ecs.provider."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from ldk.interfaces.provider import ProviderStartError, ProviderStatus
from ldk.providers.ecs.discovery import ServiceRegistry
from ldk.providers.ecs.provider import (
    ContainerDefinition,
    EcsProvider,
    ServiceDefinition,
    _extract_health_path,
    _merge_container_env,
    _parse_env_list,
    _resolve_command,
    parse_ecs_resources,
    parse_task_definition,
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


class TestContainerDefinition:
    def test_defaults(self) -> None:
        cd = ContainerDefinition(name="web")
        assert cd.image == ""
        assert cd.command == []
        assert cd.entry_point == []
        assert cd.environment == {}
        assert cd.port_mappings == []
        assert cd.health_check is None


# ---------------------------------------------------------------------------
# ServiceDefinition tests
# ---------------------------------------------------------------------------


class TestServiceDefinition:
    def test_defaults(self) -> None:
        sd = ServiceDefinition(service_name="svc")
        assert sd.containers == []
        assert sd.local_command is None
        assert sd.desired_count == 1
        assert sd.watch_path is None


# ---------------------------------------------------------------------------
# EcsProvider lifecycle tests
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


# ---------------------------------------------------------------------------
# Health check integration
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


# ---------------------------------------------------------------------------
# Restart tests
# ---------------------------------------------------------------------------


class TestEcsProviderRestart:
    @patch("asyncio.create_subprocess_exec")
    async def test_restart_service(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        svc = _make_service()
        provider = EcsProvider(services=[svc])

        await provider.start()
        await provider.restart_service("web-api")
        # Service should still be tracked
        assert "web-api" in provider._processes
        await provider.stop()

    @patch("asyncio.create_subprocess_exec")
    async def test_restart_unknown_service_is_noop(self, mock_exec: AsyncMock) -> None:
        mock_exec.return_value = _mock_process()
        provider = EcsProvider(services=[])
        await provider.start()
        await provider.restart_service("nonexistent")
        await provider.stop()


# ---------------------------------------------------------------------------
# Command resolution tests
# ---------------------------------------------------------------------------


class TestResolveCommand:
    def test_local_command_takes_precedence(self) -> None:
        svc = _make_service(local_command=["npm", "start"])
        cmd = _resolve_command(svc)
        assert cmd == ["npm", "start"]

    def test_entry_point_plus_command(self) -> None:
        container = _make_container(
            entry_point=["python"],
            command=["-m", "flask", "run"],
        )
        svc = _make_service(containers=[container], local_command=None)
        cmd = _resolve_command(svc)
        assert cmd == ["python", "-m", "flask", "run"]

    def test_command_only(self) -> None:
        container = _make_container(entry_point=[], command=["node", "index.js"])
        svc = _make_service(containers=[container], local_command=None)
        cmd = _resolve_command(svc)
        assert cmd == ["node", "index.js"]

    def test_empty_when_no_command(self) -> None:
        container = _make_container(entry_point=[], command=[])
        svc = _make_service(containers=[container], local_command=None)
        cmd = _resolve_command(svc)
        assert cmd == []


# ---------------------------------------------------------------------------
# Environment merging tests
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


# ---------------------------------------------------------------------------
# Health path extraction tests
# ---------------------------------------------------------------------------


class TestExtractHealthPath:
    def test_cmd_shell_curl(self) -> None:
        cmd = ["CMD-SHELL", "curl -f http://localhost:8080/health"]
        assert _extract_health_path(cmd) == "/health"

    def test_cmd_style(self) -> None:
        cmd = ["CMD", "curl", "-f", "http://localhost:3000/ping"]
        assert _extract_health_path(cmd) == "/ping"

    def test_no_url_returns_none(self) -> None:
        cmd = ["CMD-SHELL", "exit 0"]
        assert _extract_health_path(cmd) is None

    def test_https_url(self) -> None:
        cmd = ["CMD-SHELL", "curl -f https://localhost:443/status"]
        assert _extract_health_path(cmd) == "/status"


# ---------------------------------------------------------------------------
# parse_task_definition tests
# ---------------------------------------------------------------------------


class TestParseTaskDefinition:
    def test_parses_containers(self) -> None:
        props = {
            "ContainerDefinitions": [
                {
                    "Name": "web",
                    "Image": "nginx:latest",
                    "Command": ["nginx", "-g", "daemon off;"],
                    "EntryPoint": [],
                    "Environment": [
                        {"Name": "ENV", "Value": "prod"},
                    ],
                    "PortMappings": [
                        {"ContainerPort": 80, "HostPort": 80},
                    ],
                }
            ]
        }
        containers = parse_task_definition(props)
        assert len(containers) == 1
        assert containers[0].name == "web"
        assert containers[0].image == "nginx:latest"
        assert containers[0].environment == {"ENV": "prod"}
        assert containers[0].port_mappings[0]["ContainerPort"] == 80

    def test_empty_container_definitions(self) -> None:
        containers = parse_task_definition({})
        assert containers == []


# ---------------------------------------------------------------------------
# _parse_env_list tests
# ---------------------------------------------------------------------------


class TestParseEnvList:
    def test_normal(self) -> None:
        env_list = [
            {"Name": "A", "Value": "1"},
            {"Name": "B", "Value": "2"},
        ]
        assert _parse_env_list(env_list) == {"A": "1", "B": "2"}

    def test_skips_malformed(self) -> None:
        env_list = [
            {"Name": "A", "Value": "1"},
            {"Name": "B"},  # missing Value
            {"Value": "3"},  # missing Name
        ]
        assert _parse_env_list(env_list) == {"A": "1"}


# ---------------------------------------------------------------------------
# parse_ecs_resources tests
# ---------------------------------------------------------------------------


class TestParseEcsResources:
    def test_links_service_to_task_def(self) -> None:
        template = {
            "Resources": {
                "MyTaskDef": {
                    "Type": "AWS::ECS::TaskDefinition",
                    "Properties": {
                        "ContainerDefinitions": [
                            {
                                "Name": "app",
                                "Image": "myapp:latest",
                                "Command": ["python", "app.py"],
                                "PortMappings": [{"ContainerPort": 8080}],
                                "Environment": [{"Name": "PORT", "Value": "8080"}],
                            }
                        ]
                    },
                },
                "MyService": {
                    "Type": "AWS::ECS::Service",
                    "Properties": {
                        "TaskDefinition": {"Ref": "MyTaskDef"},
                    },
                },
            }
        }
        services = parse_ecs_resources(template)
        assert len(services) == 1
        svc = services[0]
        assert svc.service_name == "MyService"
        assert len(svc.containers) == 1
        assert svc.containers[0].name == "app"

    def test_local_command_metadata(self) -> None:
        template = {
            "Resources": {
                "TaskDef": {
                    "Type": "AWS::ECS::TaskDefinition",
                    "Properties": {"ContainerDefinitions": []},
                },
                "Svc": {
                    "Type": "AWS::ECS::Service",
                    "Properties": {"TaskDefinition": "TaskDef"},
                    "Metadata": {
                        "ldk.local_command": ["npm", "run", "dev"],
                        "ldk.watch_path": "/app/src",
                    },
                },
            }
        }
        services = parse_ecs_resources(template)
        assert len(services) == 1
        assert services[0].local_command == ["npm", "run", "dev"]
        assert services[0].watch_path == "/app/src"

    def test_empty_template(self) -> None:
        services = parse_ecs_resources({})
        assert services == []

    def test_no_ecs_resources(self) -> None:
        template = {
            "Resources": {
                "Bucket": {"Type": "AWS::S3::Bucket", "Properties": {}},
            }
        }
        services = parse_ecs_resources(template)
        assert services == []


# ---------------------------------------------------------------------------
# Port extraction tests
# ---------------------------------------------------------------------------


class TestExtractPort:
    def test_extracts_host_port(self) -> None:
        svc = _make_service()
        port = EcsProvider._extract_port(svc)
        assert port == 8080

    def test_falls_back_to_container_port(self) -> None:
        container = _make_container(
            port_mappings=[{"containerPort": 3000}],
        )
        svc = _make_service(containers=[container])
        port = EcsProvider._extract_port(svc)
        assert port == 3000

    def test_no_port_mappings(self) -> None:
        container = _make_container(port_mappings=[])
        svc = _make_service(containers=[container])
        port = EcsProvider._extract_port(svc)
        assert port is None
