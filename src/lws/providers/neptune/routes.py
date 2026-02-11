"""Neptune control-plane HTTP routes.

Thin wrapper around the shared cluster-DB factory.
Target prefix: AmazonNeptune.{Action}
"""

from __future__ import annotations

from dataclasses import replace

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


def create_neptune_app(*, data_plane_endpoint: str | None = None) -> FastAPI:
    """Create a FastAPI app that speaks the Neptune wire protocol."""
    if data_plane_endpoint:
        config = replace(_NEPTUNE_CONFIG, data_plane_endpoint=data_plane_endpoint)
    else:
        config = _NEPTUNE_CONFIG
    return create_cluster_db_app(config)
