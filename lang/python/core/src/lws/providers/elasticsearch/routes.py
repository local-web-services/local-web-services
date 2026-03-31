"""Elasticsearch HTTP routes.

Thin wrapper around the shared search-service factory.
"""

from __future__ import annotations

from dataclasses import replace

from fastapi import FastAPI

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, TrackerRegistry
from lws.providers._shared.search_service import (
    SearchServiceConfig,
    _SearchState,
    create_search_service_app,
)

_ES_CONFIG = SearchServiceConfig(
    service_name="elasticsearch",
    logger_name="ldk.elasticsearch",
    arn_service="es",
    endpoint_suffix="es.amazonaws.com",
    default_version="7.10",
    default_instance_type="m5.large.elasticsearch",
    version_field="ElasticsearchVersion",
    cluster_config_field="ElasticsearchClusterConfig",
    action_map={
        "CreateDomain": "CreateElasticsearchDomain",
        "DescribeDomain": "DescribeElasticsearchDomain",
        "DescribeDomains": "DescribeElasticsearchDomains",
        "DeleteDomain": "DeleteElasticsearchDomain",
        "ListDomainNames": "ListDomainNames",
        "ListTags": "ListTags",
        "AddTags": "AddTags",
        "RemoveTags": "RemoveTags",
    },
)


def create_elasticsearch_app(
    *,
    container_manager=None,
    lifecycle: ResourceLifecycleConfig | None = None,
    registry: TrackerRegistry | None = None,
) -> tuple[FastAPI, _SearchState]:
    """Create a FastAPI application that speaks the Elasticsearch Service wire protocol.

    Returns a tuple of (app, state) so callers can expose state for reset.
    """
    updates: dict = {}
    if container_manager:
        updates["container_manager"] = container_manager
    if lifecycle is not None:
        updates["lifecycle"] = lifecycle
    config = replace(_ES_CONFIG, **updates) if updates else _ES_CONFIG
    return create_search_service_app(config, registry=registry)
