"""DSL parser — converts YAML files in ``.lws/mocks/`` to MockServerConfig."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml

from lws.providers.mockserver.models import (
    ChaosConfig,
    GraphQLRoute,
    GrpcRoute,
    MatchCriteria,
    MockResponse,
    MockServerConfig,
    MockServerDefaults,
    RouteRule,
)


def parse_config(config_path: Path) -> MockServerConfig:
    """Parse a ``config.yaml`` file into a MockServerConfig (without routes)."""
    raw = yaml.safe_load(config_path.read_text()) or {}
    return _build_config(raw)


def _build_config(raw: dict[str, Any]) -> MockServerConfig:
    """Build a MockServerConfig from a raw dict."""
    defaults_raw = raw.get("defaults", {})
    defaults = MockServerDefaults(
        content_type=defaults_raw.get("content_type", "application/json"),
        status=defaults_raw.get("status", 200),
    )

    chaos_raw = raw.get("chaos", {})
    chaos = _build_chaos(chaos_raw)

    return MockServerConfig(
        name=raw.get("name", "unnamed"),
        description=raw.get("description", ""),
        port=raw.get("port"),
        protocol=raw.get("protocol", "rest"),
        defaults=defaults,
        chaos=chaos,
    )


def _build_chaos(raw: dict[str, Any]) -> ChaosConfig:
    """Build a ChaosConfig from a raw dict."""
    latency = raw.get("latency", {})
    status_codes = raw.get("status_codes", [])
    return ChaosConfig(
        enabled=raw.get("enabled", False),
        error_rate=raw.get("error_rate", 0.0),
        latency_min_ms=latency.get("min_ms", 0),
        latency_max_ms=latency.get("max_ms", 0),
        status_codes=[
            {"status": sc.get("status", 500), "weight": sc.get("weight", 0.0)}
            for sc in status_codes
        ],
        connection_reset_rate=raw.get("connection_reset_rate", 0.0),
        timeout_rate=raw.get("timeout_rate", 0.0),
    )


def parse_routes(routes_dir: Path, protocol: str = "rest") -> dict[str, Any]:
    """Parse all route YAML files in a directory.

    Returns a dict with ``routes``, ``graphql_routes``, ``grpc_routes`` lists.
    """
    routes: list[RouteRule] = []
    graphql_routes: list[GraphQLRoute] = []
    grpc_routes: list[GrpcRoute] = []

    if not routes_dir.exists():
        return {"routes": routes, "graphql_routes": graphql_routes, "grpc_routes": grpc_routes}

    for route_file in sorted(routes_dir.glob("*.yaml")):
        raw = yaml.safe_load(route_file.read_text()) or {}
        raw_routes = raw.get("routes", [])
        for r in raw_routes:
            if protocol == "graphql":
                graphql_routes.append(_parse_graphql_route(r))
            elif protocol == "grpc":
                grpc_routes.append(_parse_grpc_route(r))
            else:
                routes.append(_parse_rest_route(r))

    return {"routes": routes, "graphql_routes": graphql_routes, "grpc_routes": grpc_routes}


def _parse_rest_route(raw: dict[str, Any]) -> RouteRule:
    """Parse a single REST route definition."""
    responses: list[tuple[MatchCriteria, MockResponse]] = []
    for resp_raw in raw.get("responses", []):
        criteria = _parse_match_criteria(resp_raw.get("match", {}))
        response = MockResponse(
            status=resp_raw.get("status", 200),
            headers=resp_raw.get("headers", {}),
            body=resp_raw.get("body"),
            delay_ms=resp_raw.get("delay_ms", 0),
        )
        responses.append((criteria, response))

    return RouteRule(
        path=raw.get("path", "/"),
        method=raw.get("method", "GET").upper(),
        summary=raw.get("summary", ""),
        responses=responses,
    )


def _parse_match_criteria(raw: dict[str, Any]) -> MatchCriteria:
    """Parse match criteria from a raw dict."""
    return MatchCriteria(
        headers=raw.get("headers", {}),
        path_params=raw.get("path_params", {}),
        query_params=raw.get("query_params", {}),
        body_matchers=raw.get("body", {}),
    )


def _parse_graphql_route(raw: dict[str, Any]) -> GraphQLRoute:
    """Parse a single GraphQL route definition."""
    return GraphQLRoute(
        operation=raw.get("operation", ""),
        match=raw.get("match", {}),
        response=raw.get("response", {}),
    )


def _parse_grpc_route(raw: dict[str, Any]) -> GrpcRoute:
    """Parse a single gRPC route definition."""
    return GrpcRoute(
        service=raw.get("service", ""),
        method=raw.get("method", ""),
        match=raw.get("match", {}),
        response=raw.get("response", {}),
    )


def load_mock_server(mock_dir: Path) -> MockServerConfig:
    """Load a complete mock server configuration from a directory.

    Expects ``config.yaml`` and an optional ``routes/`` subdirectory.
    """
    config_path = mock_dir / "config.yaml"
    if not config_path.exists():
        raise FileNotFoundError(f"config.yaml not found in {mock_dir}")

    config = parse_config(config_path)
    routes_dir = mock_dir / "routes"
    parsed = parse_routes(routes_dir, config.protocol)

    config.routes = parsed["routes"]
    config.graphql_routes = parsed["graphql_routes"]
    config.grpc_routes = parsed["grpc_routes"]
    return config


def generate_config_yaml(
    name: str,
    *,
    port: int | None = None,
    protocol: str = "rest",
    description: str = "",
) -> str:
    """Generate a config.yaml template string."""
    lines = [
        f"name: {name}",
    ]
    if description:
        lines.append(f"description: {description}")
    if port is not None:
        lines.append(f"port: {port}")
    lines.append(f"protocol: {protocol}")
    lines.append("")
    lines.append("defaults:")
    lines.append("  content_type: application/json")
    lines.append("  status: 200")
    lines.append("")
    lines.append("chaos:")
    lines.append("  enabled: false")
    lines.append("  error_rate: 0.0")
    lines.append("  latency:")
    lines.append("    min_ms: 0")
    lines.append("    max_ms: 0")
    lines.append("")
    return "\n".join(lines)


def generate_route_yaml(
    path: str,
    method: str = "GET",
    status: int = 200,
    body: Any = None,
    headers: dict[str, str] | None = None,
) -> str:
    """Generate a route YAML string for a single route."""
    route: dict[str, Any] = {"path": path, "method": method.upper()}
    resp: dict[str, Any] = {"match": {}, "status": status}
    if headers:
        resp["headers"] = headers
    if body is not None:
        resp["body"] = body
    route["responses"] = [resp]
    return yaml.dump({"routes": [route]}, default_flow_style=False, sort_keys=False)
