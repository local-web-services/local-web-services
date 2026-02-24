"""Shared Docker client factory.

Discovers the Docker daemon socket and returns a connected client.
Used by Lambda runtime, ElastiCache, MemoryDB, DocumentDB, Neptune,
Elasticsearch, OpenSearch, and RDS providers.
"""

from __future__ import annotations

from pathlib import Path


def _socket_candidates() -> list[Path]:
    """Return well-known Docker socket paths to probe."""
    home = Path.home()
    return [
        home / ".colima" / "default" / "docker.sock",
        home / ".colima" / "docker.sock",
        home / ".rd" / "docker.sock",
        Path("/var/run/docker.sock"),
        home / ".docker" / "run" / "docker.sock",
    ]


def create_docker_client():
    """Create a Docker client, discovering the socket if necessary.

    Tries ``docker.from_env()`` first (which honours ``DOCKER_HOST``).
    If that fails, probes well-known socket paths for Colima, Rancher
    Desktop, and Docker Desktop before giving up.
    """
    import docker  # pylint: disable=import-outside-toplevel

    # Fast path: DOCKER_HOST is set or the default socket works.
    try:
        client = docker.from_env()
        client.ping()
        return client
    except Exception:
        pass

    # Probe well-known alternative socket paths.
    for sock in _socket_candidates():
        if sock.exists():
            try:
                client = docker.DockerClient(base_url=f"unix://{sock}")
                client.ping()
                return client
            except Exception:
                continue

    raise docker.errors.DockerException(
        "Cannot connect to Docker daemon. Is Docker or Colima running? "
        "You can also set the DOCKER_HOST environment variable."
    )
