"""DocumentDB control-plane HTTP routes.

Thin wrapper around the shared cluster-DB factory.
Target prefix: AmazonRDSv19.{Action}
"""

from __future__ import annotations

from fastapi import FastAPI

from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, TrackerRegistry
from lws.providers._shared.cluster_db_service import (
    ClusterDBConfig,
    _ClusterDBState,
    create_cluster_db_app,
)
from lws.providers._shared.provider_context import ProviderContext

_DOCDB_CONFIG = ClusterDBConfig(
    service_name="docdb",
    display_name="DocumentDB",
    logger_name="ldk.docdb",
    arn_service="rds",
    default_engine="docdb",
    default_port=27017,
    default_instance_class="db.r5.large",
    endpoint_suffix="docdb.amazonaws.com",
    include_master_username=True,
    include_remove_tags=True,
    use_query_protocol=True,
)


def create_docdb_app(
    *,
    container_manager=None,
    lifecycle: ResourceLifecycleConfig | None = None,
    capacity: AwsCapacityConfig | None = None,
    registry: TrackerRegistry | None = None,
    context: ProviderContext | None = None,
) -> tuple[FastAPI, _ClusterDBState]:
    """Create a FastAPI app that speaks the DocumentDB wire protocol.

    Returns a tuple of (app, state) so the caller can register state for reset.
    """
    app, state = create_cluster_db_app(
        _DOCDB_CONFIG.with_overrides(container_manager, lifecycle, capacity),
        registry=registry,
    )
    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "docdb")
    return app, state
