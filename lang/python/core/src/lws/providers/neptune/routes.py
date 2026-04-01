"""Neptune control-plane HTTP routes.

Thin wrapper around the shared cluster-DB factory.
Target prefix: AmazonNeptune.{Action}
"""

from __future__ import annotations

from fastapi import FastAPI

from lws.interfaces.cloudtrail import ICloudTrail  # noqa: TC001
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, TrackerRegistry
from lws.providers._shared.cluster_db_service import (
    ClusterDBConfig,
    _ClusterDBState,
    create_cluster_db_app,
)

_NEPTUNE_CONFIG = ClusterDBConfig(
    service_name="neptune",
    display_name="Neptune",
    logger_name="ldk.neptune",
    arn_service="neptune",
    default_engine="neptune",
    default_port=8182,
    default_instance_class="db.r5.large",
    endpoint_suffix="neptune.amazonaws.com",
    include_remove_tags=False,
    use_query_protocol=True,
)


def create_neptune_app(
    *,
    container_manager=None,
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
    registry: TrackerRegistry | None = None,
    cloudtrail_provider: ICloudTrail | None = None,
) -> tuple[FastAPI, _ClusterDBState]:
    """Create a FastAPI app that speaks the Neptune wire protocol.

    Returns a tuple of (app, state) so the caller can register state for reset.
    """
    app, state = create_cluster_db_app(
        _NEPTUNE_CONFIG.with_overrides(container_manager, lifecycle, capacity),
        registry=registry,
    )
    apply_cloudtrail_middleware(app, cloudtrail_provider, "neptune")
    return app, state
