"""Data models for the fake server provider."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any


@dataclass
class MatchCriteria:
    """Criteria for matching an incoming request to a fake response."""

    headers: dict[str, str] = field(default_factory=dict)
    path_params: dict[str, str] = field(default_factory=dict)
    query_params: dict[str, str] = field(default_factory=dict)
    body_matchers: dict[str, Any] = field(default_factory=dict)


@dataclass
class FakeResponse:
    """A fake response to return when a request matches."""

    status: int = 200
    headers: dict[str, str] = field(default_factory=dict)
    body: Any = None
    delay_ms: int = 0


@dataclass
class RouteRule:
    """A single route rule mapping a path+method to ordered responses."""

    path: str
    method: str
    summary: str = ""
    responses: list[tuple[MatchCriteria, FakeResponse]] = field(default_factory=list)


@dataclass
class GraphQLRoute:
    """A GraphQL operation route rule."""

    operation: str
    match: dict[str, Any] = field(default_factory=dict)
    response: dict[str, Any] = field(default_factory=dict)


@dataclass
class GrpcRoute:
    """A gRPC method route rule."""

    service: str
    method: str
    match: dict[str, Any] = field(default_factory=dict)
    response: dict[str, Any] = field(default_factory=dict)


@dataclass
class ChaosConfig:
    """Chaos engineering configuration for a fake server."""

    enabled: bool = False
    error_rate: float = 0.0
    latency_min_ms: int = 0
    latency_max_ms: int = 0
    status_codes: list[dict[str, Any]] = field(default_factory=list)
    connection_reset_rate: float = 0.0
    timeout_rate: float = 0.0


@dataclass
class FakeServerDefaults:
    """Default values for fake server responses."""

    content_type: str = "application/json"
    status: int = 200


@dataclass
class FakeServerConfig:
    """Configuration for a single fake server."""

    name: str
    description: str = ""
    port: int | None = None
    protocol: str = "rest"
    defaults: FakeServerDefaults = field(default_factory=FakeServerDefaults)
    chaos: ChaosConfig = field(default_factory=ChaosConfig)
    routes: list[RouteRule] = field(default_factory=list)
    graphql_routes: list[GraphQLRoute] = field(default_factory=list)
    grpc_routes: list[GrpcRoute] = field(default_factory=list)
