"""Elasticsearch data-plane provider backed by OpenSearch."""

from __future__ import annotations

from lws.providers._shared.docker_service import DataPlaneProvider
from lws.providers._shared.opensearch_config import opensearch_docker_config


class ElasticsearchDataPlaneProvider(DataPlaneProvider):
    """Manages an OpenSearch container for the Elasticsearch data-plane."""

    def __init__(self, port: int) -> None:
        super().__init__(
            "elasticsearch-data",
            opensearch_docker_config(
                container_name="lws-elasticsearch-opensearch",
                host_port=port,
            ),
        )
