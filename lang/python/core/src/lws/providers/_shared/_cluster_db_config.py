"""ClusterDBConfig dataclass shared between DocumentDB and Neptune providers."""

from __future__ import annotations

from dataclasses import dataclass, replace

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers._shared.resource_container import ResourceContainerManager


@dataclass
class ClusterDBConfig:
    """Configuration that varies between DocumentDB and Neptune."""

    service_name: str
    display_name: str
    logger_name: str
    arn_service: str
    default_engine: str
    default_port: int
    default_instance_class: str
    endpoint_suffix: str
    include_master_username: bool = False
    include_remove_tags: bool = True
    use_query_protocol: bool = False
    container_manager: ResourceContainerManager | None = None
    lifecycle: ResourceLifecycleConfig | None = None
    capacity: AwsCapacityConfig | None = None

    def with_overrides(
        self,
        container_manager: ResourceContainerManager | None = None,
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
    ) -> ClusterDBConfig:
        """Return a copy with optional runtime overrides applied."""
        overrides: dict = {}
        if container_manager:
            overrides["container_manager"] = container_manager
        if lifecycle is not None:
            overrides["lifecycle"] = lifecycle
        if capacity is not None:
            overrides["capacity"] = capacity
        return replace(self, **overrides) if overrides else self
