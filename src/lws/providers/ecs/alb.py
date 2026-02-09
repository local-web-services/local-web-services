"""ALB integration and HTTP routing for ECS services.

Parses ALB listener-rule configuration and provides a local FastAPI
application that routes requests to the appropriate ECS service port
based on path conditions.  Requests are proxied transparently using
``httpx.AsyncClient``.
"""

from __future__ import annotations

import logging
from collections.abc import AsyncIterator
from contextlib import asynccontextmanager
from dataclasses import dataclass, field

import httpx
from fastapi import FastAPI, Request
from fastapi.responses import Response

logger = logging.getLogger(__name__)


@dataclass
class ListenerRule:
    """A single ALB listener rule mapping a path pattern to a target.

    Attributes:
        priority: Rule evaluation priority (lower = evaluated first).
        path_pattern: URL path pattern (e.g. ``/api/*``).
        target_host: Hostname of the backend target.
        target_port: Port of the backend target.
        health_check_path: Optional health-check path for the target group.
    """

    priority: int
    path_pattern: str
    target_host: str = "localhost"
    target_port: int = 8080
    health_check_path: str | None = None


@dataclass
class AlbConfig:
    """Configuration for the local ALB proxy.

    Attributes:
        listener_rules: Ordered list of listener rules.
        port: Port on which the local ALB server listens.
    """

    listener_rules: list[ListenerRule] = field(default_factory=list)
    port: int = 8080


def _path_matches(pattern: str, path: str) -> bool:
    """Return ``True`` if *path* matches an ALB *pattern*.

    ALB patterns use ``*`` as a wildcard for any number of characters.
    This is a simplified matcher: a trailing ``*`` matches any suffix,
    and a leading ``*`` matches any prefix.
    """
    if pattern == "*" or pattern == "/*":
        return True
    if pattern.endswith("*"):
        return path.startswith(pattern[:-1])
    if pattern.startswith("*"):
        return path.endswith(pattern[1:])
    return path == pattern


def _find_matching_rule(rules: list[ListenerRule], path: str) -> ListenerRule | None:
    """Return the first listener rule whose path-pattern matches *path*.

    Rules are evaluated in priority order (ascending).
    """
    sorted_rules = sorted(rules, key=lambda r: r.priority)
    for rule in sorted_rules:
        if _path_matches(rule.path_pattern, path):
            return rule
    return None


async def _proxy_request(
    client: httpx.AsyncClient,
    rule: ListenerRule,
    request: Request,
) -> Response:
    """Forward *request* to the backend identified by *rule*.

    Headers and status codes are passed through transparently.
    """
    target_url = f"http://{rule.target_host}:{rule.target_port}{request.url.path}"
    body = await request.body()

    # Forward all headers except ``host`` (httpx sets it automatically).
    headers = {k: v for k, v in request.headers.items() if k.lower() != "host"}

    resp = await client.request(
        method=request.method,
        url=target_url,
        headers=headers,
        content=body,
        params=dict(request.query_params),
    )

    # Pass response headers through, excluding hop-by-hop.
    excluded = {"transfer-encoding", "content-encoding", "content-length"}
    resp_headers = {k: v for k, v in resp.headers.items() if k.lower() not in excluded}

    return Response(
        content=resp.content,
        status_code=resp.status_code,
        headers=resp_headers,
    )


def build_alb_app(config: AlbConfig) -> FastAPI:
    """Create a FastAPI application that acts as a local ALB proxy.

    All incoming requests are matched against the configured listener rules
    and proxied to the appropriate backend target.

    Args:
        config: ALB configuration with listener rules.

    Returns:
        A FastAPI app ready to be served.
    """
    client = httpx.AsyncClient(timeout=30.0)
    rules = config.listener_rules

    @asynccontextmanager
    async def _lifespan(app: FastAPI) -> AsyncIterator[None]:
        yield
        await client.aclose()

    app = FastAPI(title="LDK ALB Proxy", lifespan=_lifespan)

    # Register health-check endpoints for each target group.
    for rule in rules:
        if rule.health_check_path:
            _register_health_route(app, client, rule)

    @app.api_route("/{path:path}", methods=["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"])
    async def _catch_all(request: Request) -> Response:
        matched = _find_matching_rule(rules, request.url.path)
        if matched is None:
            return Response(content="No matching rule", status_code=404)
        return await _proxy_request(client, matched, request)

    return app


def _register_health_route(
    app: FastAPI,
    client: httpx.AsyncClient,
    rule: ListenerRule,
) -> None:
    """Register a dedicated health-check route for *rule*."""
    hc_path = rule.health_check_path

    async def _health(request: Request) -> Response:
        return await _proxy_request(client, rule, request)

    app.add_api_route(
        path=hc_path,  # type: ignore[arg-type]
        endpoint=_health,
        methods=["GET"],
    )


def parse_listener_rules(resources: dict) -> list[ListenerRule]:
    """Parse ALB listener rules from CloudFormation-style resources.

    Expects resources of type ``AWS::ElasticLoadBalancingV2::ListenerRule``
    with ``Properties`` containing ``Conditions`` and ``Actions``.

    Args:
        resources: Dict of logical-id to resource definitions.

    Returns:
        A list of :class:`ListenerRule` instances.
    """
    rules: list[ListenerRule] = []
    for _logical_id, res in resources.items():
        if res.get("Type") != "AWS::ElasticLoadBalancingV2::ListenerRule":
            continue
        props = res.get("Properties", {})
        rule = _parse_single_rule(props)
        if rule is not None:
            rules.append(rule)
    return rules


def _parse_single_rule(props: dict) -> ListenerRule | None:
    """Parse a single listener rule from its CloudFormation *props*."""
    priority = props.get("Priority", 100)
    path_pattern = _extract_path_pattern(props.get("Conditions", []))
    if path_pattern is None:
        return None

    return ListenerRule(
        priority=int(priority),
        path_pattern=path_pattern,
    )


def _extract_path_pattern(conditions: list[dict]) -> str | None:
    """Extract the first path-pattern value from ALB *conditions*."""
    for cond in conditions:
        if cond.get("Field") == "path-pattern":
            values = cond.get("Values", [])
            if values:
                return values[0]
        path_config = cond.get("PathPatternConfig", {})
        values = path_config.get("Values", [])
        if values:
            return values[0]
    return None
