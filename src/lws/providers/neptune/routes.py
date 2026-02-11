"""Neptune control-plane HTTP routes.

Thin wrapper around the shared cluster-DB factory.
Target prefix: AmazonNeptune.{Action}
"""

from __future__ import annotations

from fastapi import FastAPI

from lws.providers._shared.cluster_db_service import ClusterDBConfig, create_cluster_db_app

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
)


def create_neptune_app() -> FastAPI:
    """Create a FastAPI app that speaks the Neptune wire protocol."""
    return create_cluster_db_app(_NEPTUNE_CONFIG)
