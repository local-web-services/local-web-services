"""OpenSearch HTTP routes.

Thin wrapper around the shared search-service factory.
"""

from __future__ import annotations

from fastapi import FastAPI

from lws.providers._shared.search_service import SearchServiceConfig, create_search_service_app

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


def create_opensearch_app() -> FastAPI:
    """Create a FastAPI application that speaks the OpenSearch Service wire protocol."""
    return create_search_service_app(_OPENSEARCH_CONFIG)
