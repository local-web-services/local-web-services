"""Tests for ldk.providers.ecs.provider."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock

from lws.providers.ecs.provider import (
    ContainerDefinition,
    ServiceDefinition,
    parse_ecs_resources,
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
        assert len(services) == 1, f"Expected {1!r} but got {len(services)!r}"
        svc = services[0]
        assert (
            svc.service_name == "MyService"
        ), f'Expected {"MyService"!r} but got {svc.service_name!r}'
        assert len(svc.containers) == 1, f"Expected {1!r} but got {len(svc.containers)!r}"
        assert (
            svc.containers[0].name == "app"
        ), f'Expected {"app"!r} but got {svc.containers[0].name!r}'

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
        assert len(services) == 1, f"Expected {1!r} but got {len(services)!r}"
        assert services[0].local_command == [
            "npm",
            "run",
            "dev",
        ], f'Expected {["npm", "run", "dev"]!r} but got {services[0].local_command!r}'
        assert (
            services[0].watch_path == "/app/src"
        ), f'Expected {"/app/src"!r} but got {services[0].watch_path!r}'

    def test_empty_template(self) -> None:
        services = parse_ecs_resources({})
        assert services == [], f"Expected {[]!r} but got {services!r}"

    def test_no_ecs_resources(self) -> None:
        template = {
            "Resources": {
                "Bucket": {"Type": "AWS::S3::Bucket", "Properties": {}},
            }
        }
        services = parse_ecs_resources(template)
        assert services == [], f"Expected {[]!r} but got {services!r}"
