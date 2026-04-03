"""OpenSearch HTTP routes.

Thin wrapper around the shared search-service factory.
"""

from __future__ import annotations

from dataclasses import replace

from fastapi import FastAPI

from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig, TrackerRegistry
from lws.providers._shared.provider_context import ProviderContext
from lws.providers._shared.search_service import (
    SearchServiceConfig,
    _SearchState,
    create_search_service_app,
)

_OPENSEARCH_CONFIG = SearchServiceConfig(
    service_name="opensearch",
    logger_name="ldk.opensearch",
    arn_service="opensearch",
    endpoint_suffix="aoss.amazonaws.com",
    default_version="OpenSearch_2.11",
    default_instance_type="m5.large.search",
    version_field="EngineVersion",
    cluster_config_field="ClusterConfig",
    action_map={
        "CreateDomain": "CreateDomain",
        "DescribeDomain": "DescribeDomain",
        "DescribeDomains": "DescribeDomains",
        "DeleteDomain": "DeleteDomain",
        "ListDomainNames": "ListDomainNames",
        "ListTags": "ListTags",
        "AddTags": "AddTags",
        "RemoveTags": "RemoveTags",
    },
    list_domain_extra={"EngineType": "OpenSearch"},
)


def create_opensearch_app(
    *,
    container_manager=None,
    lifecycle: ResourceLifecycleConfig | None = None,
    registry: TrackerRegistry | None = None,
    context: ProviderContext | None = None,
) -> tuple[FastAPI, _SearchState]:
    """Create a FastAPI application that speaks the OpenSearch Service wire protocol.

    Returns a tuple of (app, state) so callers can expose state for reset.
    """
    updates: dict = {}
    if container_manager:
        updates["container_manager"] = container_manager
    if lifecycle is not None:
        updates["lifecycle"] = lifecycle
    config = replace(_OPENSEARCH_CONFIG, **updates) if updates else _OPENSEARCH_CONFIG
    app, state = create_search_service_app(config, registry=registry)
    apply_cloudtrail_middleware(app, context.cloudtrail if context else None, "opensearch")
    return app, state
