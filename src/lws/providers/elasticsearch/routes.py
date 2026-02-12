"""Elasticsearch HTTP routes.

Thin wrapper around the shared search-service factory.
"""

from __future__ import annotations

from dataclasses import replace

from fastapi import FastAPI

from lws.providers._shared.search_service import SearchServiceConfig, create_search_service_app

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


def create_elasticsearch_app(*, container_manager=None) -> FastAPI:
    """Create a FastAPI application that speaks the Elasticsearch Service wire protocol."""
    if container_manager:
        config = replace(_ES_CONFIG, container_manager=container_manager)
    else:
        config = _ES_CONFIG
    return create_search_service_app(config)
