"""Shared OpenSearch Docker configuration.

Both the Elasticsearch and OpenSearch data-plane providers use
the same ``opensearchproject/opensearch:2`` image with identical
settings.  This factory avoids duplicating the configuration.
"""

from __future__ import annotations

from lws.providers._shared.docker_service import DockerServiceConfig


def opensearch_docker_config(*, container_name: str, host_port: int) -> DockerServiceConfig:
    """Return a ``DockerServiceConfig`` for an OpenSearch container."""
    return DockerServiceConfig(
        image="opensearchproject/opensearch:2",
        container_name=container_name,
        internal_port=9200,
        host_port=host_port,
        environment={
            "discovery.type": "single-node",
            "DISABLE_SECURITY_PLUGIN": "true",
        },
        startup_timeout=60.0,
    )
