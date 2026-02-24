"""Service discovery registry for locally running ECS services.

Maintains a mapping from service name to ``localhost:<port>`` so that other
providers (e.g. Lambda) can discover where each ECS service is listening.
Endpoints are injected as environment variables into compute providers on
request.
"""

from __future__ import annotations

import logging
from dataclasses import dataclass

logger = logging.getLogger(__name__)


@dataclass(frozen=True)
class ServiceEndpoint:
    """A single registered service endpoint.

    Attributes:
        service_name: Logical ECS service name.
        host: Hostname (typically ``localhost``).
        port: TCP port the service is listening on.
    """

    service_name: str
    host: str
    port: int

    @property
    def url(self) -> str:
        """Return the full base URL for this endpoint."""
        return f"http://{self.host}:{self.port}"


class ServiceRegistry:
    """Thread-safe in-memory registry of service endpoints.

    Services register on start and deregister on stop.  Other components
    query the registry to discover where a service is reachable.
    """

    def __init__(self) -> None:
        self._endpoints: dict[str, ServiceEndpoint] = {}

    def register(self, endpoint: ServiceEndpoint) -> None:
        """Register (or re-register) a service endpoint."""
        self._endpoints[endpoint.service_name] = endpoint
        logger.info(
            "Registered service %s at %s",
            endpoint.service_name,
            endpoint.url,
        )

    def deregister(self, service_name: str) -> None:
        """Remove a service from the registry."""
        removed = self._endpoints.pop(service_name, None)
        if removed is not None:
            logger.info("Deregistered service %s", service_name)

    def lookup(self, service_name: str) -> ServiceEndpoint | None:
        """Look up the endpoint for *service_name*, or ``None``."""
        return self._endpoints.get(service_name)

    def all_endpoints(self) -> dict[str, ServiceEndpoint]:
        """Return a snapshot of all registered endpoints."""
        return dict(self._endpoints)

    def build_env_vars(self, prefix: str = "LDK_ECS_") -> dict[str, str]:
        """Build environment variables for all registered services.

        Each entry has the form ``<prefix><SERVICE_NAME>=<url>``.  The
        service name is upper-cased and hyphens are replaced with
        underscores.

        Args:
            prefix: String prepended to each variable name.

        Returns:
            A dict of environment variable name to URL.
        """
        env: dict[str, str] = {}
        for name, ep in self._endpoints.items():
            key = prefix + name.upper().replace("-", "_")
            env[key] = ep.url
        return env
