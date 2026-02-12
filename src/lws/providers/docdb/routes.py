"""DocumentDB control-plane HTTP routes.

Thin wrapper around the shared cluster-DB factory.
Target prefix: AmazonRDSv19.{Action}
"""

from __future__ import annotations

from dataclasses import replace

from fastapi import FastAPI

from lws.providers._shared.cluster_db_service import ClusterDBConfig, create_cluster_db_app

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
)


def create_docdb_app(*, container_manager=None) -> FastAPI:
    """Create a FastAPI app that speaks the DocumentDB wire protocol."""
    if container_manager:
        config = replace(_DOCDB_CONFIG, container_manager=container_manager)
    else:
        config = _DOCDB_CONFIG
    return create_cluster_db_app(config)
