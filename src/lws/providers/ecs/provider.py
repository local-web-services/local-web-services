"""ECS provider implementing the Provider ABC.

Orchestrates process management, health checking, service discovery, and
(optionally) ALB routing for locally-running ECS services.  Each service
is represented by a :class:`ServiceDefinition` parsed from the CDK cloud
assembly output.
"""

from __future__ import annotations

import asyncio
import logging
from dataclasses import dataclass, field

from lws.interfaces.provider import Provider, ProviderStartError, ProviderStatus
from lws.providers.ecs.discovery import ServiceEndpoint, ServiceRegistry
from lws.providers.ecs.health_check import HealthCheckConfig, HealthChecker, HealthStatus
from lws.providers.ecs.process_manager import ManagedProcess, ProcessConfig

logger = logging.getLogger(__name__)

_DEFAULT_DEBOUNCE = 0.5


@dataclass
class ContainerDefinition:
    """Parsed container definition from an ECS task.

    Attributes:
        name: Container name.
        image: Docker image reference (informational in local mode).
        command: Command to run (CMD).
        entry_point: Container entry-point (ENTRYPOINT).
        environment: Environment variable mapping.
        port_mappings: List of ``{"containerPort": int, "hostPort": int}``.
        health_check: Optional health check configuration dict.
    """

    name: str
    image: str = ""
    command: list[str] = field(default_factory=list)
    entry_point: list[str] = field(default_factory=list)
    environment: dict[str, str] = field(default_factory=dict)
    port_mappings: list[dict[str, int]] = field(default_factory=list)
    health_check: dict | None = None


@dataclass
class ServiceDefinition:
    """Fully resolved definition of an ECS service to run locally.

    Attributes:
        service_name: Logical service name.
        containers: Container definitions from the task definition.
        local_command: Override command for local execution (from
            ``ldk.local_command`` metadata).
        desired_count: Number of tasks (only 1 supported locally).
        watch_path: Optional directory to watch for code changes.
    """

    service_name: str
    containers: list[ContainerDefinition] = field(default_factory=list)
    local_command: list[str] | None = None
    desired_count: int = 1
    watch_path: str | None = None


class EcsProvider(Provider):
    """Provider that runs ECS services as local subprocesses.

    For each :class:`ServiceDefinition`, a subprocess is started with the
    configured command and environment.  Health checks are polled in the
    background.  The service discovery registry is updated on start/stop.
    """

    def __init__(
        self,
        services: list[ServiceDefinition] | None = None,
        registry: ServiceRegistry | None = None,
    ) -> None:
        self._services = services or []
        self._registry = registry or ServiceRegistry()
        self._status = ProviderStatus.STOPPED
        self._processes: dict[str, ManagedProcess] = {}
        self._checkers: dict[str, HealthChecker] = {}
        self._debounce_timers: dict[str, asyncio.TimerHandle] = {}

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        """Return the unique name of this provider."""
        return "ecs"

    async def start(self) -> None:
        """Start all configured ECS services."""
        self._status = ProviderStatus.STARTING
        try:
            for svc in self._services:
                await self._start_service(svc)
        except Exception as exc:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError(f"Failed to start ECS services: {exc}") from exc
        self._status = ProviderStatus.RUNNING

    async def stop(self) -> None:
        """Stop all running ECS services."""
        for svc_name in list(self._processes):
            await self._stop_service(svc_name)
        self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        """Return ``True`` when all services with health checks are healthy."""
        if self._status is not ProviderStatus.RUNNING:
            return False
        if not self._checkers:
            return True
        return all(c.status == HealthStatus.HEALTHY for c in self._checkers.values())

    # -- Service lifecycle helpers -------------------------------------------

    async def _start_service(self, svc: ServiceDefinition) -> None:
        """Start a single service: spawn process, register, health-check."""
        config = self._build_process_config(svc)
        process = ManagedProcess(config)
        await process.start()
        self._processes[svc.service_name] = process

        port = self._extract_port(svc)
        if port is not None:
            ep = ServiceEndpoint(
                service_name=svc.service_name,
                host="localhost",
                port=port,
            )
            self._registry.register(ep)

        hc_config = self._build_health_config(svc, port)
        if hc_config is not None:
            checker = HealthChecker(hc_config)
            checker.start()
            self._checkers[svc.service_name] = checker

    async def _stop_service(self, service_name: str) -> None:
        """Stop a single service: cancel health check, stop process, deregister."""
        checker = self._checkers.pop(service_name, None)
        if checker is not None:
            await checker.stop()

        process = self._processes.pop(service_name, None)
        if process is not None:
            await process.stop()

        self._registry.deregister(service_name)

    async def restart_service(self, service_name: str) -> None:
        """Restart a single service (used on code changes)."""
        svc = self._find_service(service_name)
        if svc is None:
            logger.warning("Cannot restart unknown service %s", service_name)
            return
        await self._stop_service(service_name)
        await self._start_service(svc)

    def schedule_restart(self, service_name: str) -> None:
        """Schedule a debounced restart for *service_name*.

        Multiple rapid calls within the debounce window result in a single
        restart.
        """
        existing = self._debounce_timers.pop(service_name, None)
        if existing is not None:
            existing.cancel()

        loop = asyncio.get_event_loop()
        handle = loop.call_later(
            _DEFAULT_DEBOUNCE,
            lambda: asyncio.ensure_future(self.restart_service(service_name)),
        )
        self._debounce_timers[service_name] = handle

    # -- Configuration helpers -----------------------------------------------

    def _find_service(self, service_name: str) -> ServiceDefinition | None:
        """Return the service definition for *service_name*."""
        for svc in self._services:
            if svc.service_name == service_name:
                return svc
        return None

    @staticmethod
    def _build_process_config(svc: ServiceDefinition) -> ProcessConfig:
        """Build a :class:`ProcessConfig` from a service definition."""
        command = _resolve_command(svc)
        env = _merge_container_env(svc)
        return ProcessConfig(
            service_name=svc.service_name,
            command=command,
            environment=env,
            working_dir=svc.watch_path,
        )

    @staticmethod
    def _extract_port(svc: ServiceDefinition) -> int | None:
        """Return the first mapped host-port from the service containers."""
        for container in svc.containers:
            for mapping in container.port_mappings:
                port = mapping.get("hostPort") or mapping.get("containerPort")
                if port is not None:
                    return int(port)
        return None

    @staticmethod
    def _build_health_config(
        svc: ServiceDefinition,
        port: int | None,
    ) -> HealthCheckConfig | None:
        """Build a health-check config from the first container with one."""
        for container in svc.containers:
            hc = container.health_check
            if hc is None:
                continue
            cmd = hc.get("command", [])
            path = _extract_health_path(cmd)
            if path is None or port is None:
                continue
            return HealthCheckConfig(
                endpoint=f"http://localhost:{port}{path}",
                interval=hc.get("interval", 30),
                timeout=hc.get("timeout", 5),
                retries=hc.get("retries", 3),
                start_period=hc.get("startPeriod", 0),
            )
        return None


# ---------------------------------------------------------------------------
# Cloud assembly parsing helpers
# ---------------------------------------------------------------------------


def _resolve_command(svc: ServiceDefinition) -> list[str]:
    """Determine the command to execute for *svc*.

    Precedence: ``local_command`` > ``entry_point + command`` > ``command``.
    """
    if svc.local_command:
        return list(svc.local_command)
    for container in svc.containers:
        parts: list[str] = []
        parts.extend(container.entry_point)
        parts.extend(container.command)
        if parts:
            return parts
    return []


def _merge_container_env(svc: ServiceDefinition) -> dict[str, str]:
    """Merge environment variables from all containers in *svc*."""
    env: dict[str, str] = {}
    for container in svc.containers:
        env.update(container.environment)
    return env


def _extract_health_path(cmd: list[str]) -> str | None:
    """Extract an HTTP path from an ECS health-check command list.

    Common patterns: ``["CMD-SHELL", "curl -f http://localhost:8080/health"]``
    or ``["CMD", "curl", "-f", "http://localhost:8080/health"]``.
    """
    for token in cmd:
        if token.startswith("http://") or token.startswith("https://"):
            from urllib.parse import urlparse

            return urlparse(token).path
        if "localhost" in token and "/" in token:
            idx = token.find("/", token.find("localhost"))
            if idx >= 0:
                return token[idx:]
    return None


def parse_task_definition(resources: dict) -> list[ContainerDefinition]:
    """Parse container definitions from an ``AWS::ECS::TaskDefinition``.

    Args:
        resources: CloudFormation resource properties dict containing
            a ``ContainerDefinitions`` key.

    Returns:
        A list of parsed :class:`ContainerDefinition` instances.
    """
    raw_containers = resources.get("ContainerDefinitions", [])
    result: list[ContainerDefinition] = []
    for raw in raw_containers:
        env = _parse_env_list(raw.get("Environment", []))
        ports = raw.get("PortMappings", [])
        result.append(
            ContainerDefinition(
                name=raw.get("Name", ""),
                image=raw.get("Image", ""),
                command=raw.get("Command", []),
                entry_point=raw.get("EntryPoint", []),
                environment=env,
                port_mappings=ports,
                health_check=raw.get("HealthCheck"),
            )
        )
    return result


def _parse_env_list(env_list: list[dict]) -> dict[str, str]:
    """Convert a CloudFormation ``Environment`` list to a dict."""
    return {item["Name"]: item["Value"] for item in env_list if "Name" in item and "Value" in item}


def parse_ecs_resources(template: dict) -> list[ServiceDefinition]:
    """Parse ECS services and task definitions from a CloudFormation template.

    Links ``AWS::ECS::Service`` resources to their task definitions and
    extracts ``ldk.local_command`` metadata overrides.

    Args:
        template: A CloudFormation template dict with a ``Resources`` key.

    Returns:
        A list of :class:`ServiceDefinition` instances.
    """
    resources = template.get("Resources", {})
    task_defs = _collect_task_defs(resources)
    return _collect_services(resources, task_defs)


def _collect_task_defs(resources: dict) -> dict[str, list[ContainerDefinition]]:
    """Build a map of logical-id to parsed container definitions."""
    task_defs: dict[str, list[ContainerDefinition]] = {}
    for logical_id, res in resources.items():
        if res.get("Type") == "AWS::ECS::TaskDefinition":
            props = res.get("Properties", {})
            task_defs[logical_id] = parse_task_definition(props)
    return task_defs


def _collect_services(
    resources: dict,
    task_defs: dict[str, list[ContainerDefinition]],
) -> list[ServiceDefinition]:
    """Build service definitions by linking services to task definitions."""
    services: list[ServiceDefinition] = []
    for logical_id, res in resources.items():
        if res.get("Type") != "AWS::ECS::Service":
            continue
        svc = _build_service_from_resource(logical_id, res, task_defs)
        if svc is not None:
            services.append(svc)
    return services


def _build_service_from_resource(
    logical_id: str,
    res: dict,
    task_defs: dict[str, list[ContainerDefinition]],
) -> ServiceDefinition | None:
    """Create a single ServiceDefinition from a CloudFormation resource."""
    props = res.get("Properties", {})
    task_ref = _resolve_task_ref(props.get("TaskDefinition", ""))
    containers = task_defs.get(task_ref, [])
    metadata = res.get("Metadata", {})
    local_cmd = metadata.get("ldk.local_command")
    watch = metadata.get("ldk.watch_path")
    return ServiceDefinition(
        service_name=logical_id,
        containers=containers,
        local_command=local_cmd,
        watch_path=watch,
    )


def _resolve_task_ref(ref: str | dict) -> str:
    """Resolve a task definition reference to a logical ID."""
    if isinstance(ref, dict):
        return ref.get("Ref", "")
    return str(ref)
