"""Management API for LDK.

Provides a FastAPI ``APIRouter`` mounted at ``/_ldk/`` that exposes endpoints
for resetting local state, querying provider status, serving the web
dashboard, and streaming logs via WebSocket.
"""

from __future__ import annotations

import asyncio
from typing import Any

import httpx
from fastapi import APIRouter, Request, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse, JSONResponse
from pydantic import BaseModel

from lws.api.gui import get_dashboard_html
from lws.interfaces.provider import Provider
from lws.logging.logger import get_logger, get_ws_handler
from lws.providers._shared.aws_chaos import AwsChaosConfig, parse_chaos_config
from lws.providers._shared.aws_operation_mock import AwsMockConfig
from lws.runtime.orchestrator import Orchestrator

_logger = get_logger("ldk.management")


class StatusResponse(BaseModel):
    """Response body for the status endpoint."""

    running: bool
    providers: list[dict[str, Any]]


async def _handle_reset(
    providers_map: dict[str, Provider],
) -> JSONResponse:
    """Reset all provider data and state."""
    _logger.info("Reset requested via management API")
    reset_count = 0

    for provider in providers_map.values():
        if hasattr(provider, "reset"):
            try:
                await provider.reset()
                reset_count += 1
            except Exception as exc:
                _logger.error("Error resetting %s: %s", provider.name, exc)

    return JSONResponse(content={"status": "ok", "providers_reset": reset_count})


async def _handle_status(
    orchestrator: Orchestrator,
    providers_map: dict[str, Provider],
) -> JSONResponse:
    """Return the status of all providers."""
    provider_list: list[dict[str, Any]] = []

    for node_id, provider in providers_map.items():
        try:
            healthy = await provider.health_check()
        except Exception:
            healthy = False

        provider_list.append({"id": node_id, "name": provider.name, "healthy": healthy})

    return JSONResponse(
        content={"running": orchestrator.running, "providers": provider_list},
    )


async def _handle_ws_logs(websocket: WebSocket) -> None:
    """Stream log entries to a WebSocket client."""
    await websocket.accept()
    handler = get_ws_handler()
    if handler is None:
        await websocket.close()
        return
    for entry in handler.backlog():
        await websocket.send_json(entry)
    q = handler.subscribe()
    try:
        while True:
            entry = await q.get()
            await websocket.send_json(entry)
    except (WebSocketDisconnect, asyncio.CancelledError):
        pass
    finally:
        handler.unsubscribe(q)


async def _handle_service_proxy(request: Request) -> JSONResponse:
    """Proxy requests to local service ports (avoids browser CORS)."""
    body = await request.json()
    url = body.get("url", "")
    if not url.startswith("http://localhost:"):
        return JSONResponse(
            status_code=400,
            content={"error": "Only localhost URLs are allowed"},
        )
    try:
        async with httpx.AsyncClient() as client:
            resp = await client.request(
                method=body.get("method", "GET"),
                url=url,
                headers=body.get("headers", {}),
                content=body.get("body", ""),
                timeout=10.0,
            )
        return JSONResponse(
            content={
                "status": resp.status_code,
                "headers": dict(resp.headers),
                "body": resp.text,
            }
        )
    except Exception as exc:
        return JSONResponse(status_code=502, content={"error": str(exc)})


def create_management_router(
    orchestrator: Orchestrator,
    providers: dict[str, Provider] | None = None,
    resource_metadata: dict[str, Any] | None = None,
    chaos_configs: dict[str, AwsChaosConfig] | None = None,
    aws_mock_configs: dict[str, AwsMockConfig] | None = None,
) -> APIRouter:
    """Create a management API router.

    Args:
        orchestrator: The running ``Orchestrator`` instance.
        providers: Optional map of all providers for status reporting.
        resource_metadata: Pre-built resource metadata for the ``/_ldk/resources`` endpoint.
        chaos_configs: Map of service name to mutable ``AwsChaosConfig`` for runtime updates.
        aws_mock_configs: Map of service name to mutable ``AwsMockConfig`` for runtime updates.

    Returns:
        A FastAPI ``APIRouter`` to be included in the main application.
    """
    router = APIRouter(prefix="/_ldk", tags=["management"])
    all_providers = providers or orchestrator.providers
    _resource_metadata = resource_metadata or {}
    _chaos_configs = chaos_configs or {}
    _aws_mock_configs = aws_mock_configs or {}

    @router.post("/reset")
    async def reset_state() -> JSONResponse:
        return await _handle_reset(all_providers)

    @router.get("/status")
    async def get_status() -> JSONResponse:
        return await _handle_status(orchestrator, all_providers)

    @router.get("/resources")
    async def get_resources() -> JSONResponse:
        return JSONResponse(content=_resource_metadata)

    @router.get("/gui")
    async def dashboard() -> HTMLResponse:
        return get_dashboard_html()

    @router.websocket("/ws/logs")
    async def ws_logs(websocket: WebSocket) -> None:
        await _handle_ws_logs(websocket)

    @router.post("/shutdown")
    async def shutdown() -> JSONResponse:
        orchestrator.request_shutdown()
        return JSONResponse(content={"status": "shutting_down"})

    @router.post("/service-proxy")
    async def service_proxy(request: Request) -> JSONResponse:
        return await _handle_service_proxy(request)

    @router.get("/chaos")
    async def get_chaos() -> JSONResponse:
        return _handle_get_chaos(_chaos_configs)

    @router.post("/chaos")
    async def set_chaos(request: Request) -> JSONResponse:
        return await _handle_set_chaos(request, _chaos_configs)

    _register_aws_mock_routes(router, _aws_mock_configs)

    return router


def _register_aws_mock_routes(
    router: APIRouter,
    aws_mock_configs: dict[str, AwsMockConfig],
) -> None:
    """Register AWS mock management routes on the router."""

    @router.get("/aws-mock")
    async def get_aws_mock() -> JSONResponse:
        return _handle_get_aws_mock(aws_mock_configs)

    @router.post("/aws-mock")
    async def set_aws_mock(request: Request) -> JSONResponse:
        return await _handle_set_aws_mock(request, aws_mock_configs)


def _handle_get_chaos(chaos_configs: dict[str, AwsChaosConfig]) -> JSONResponse:
    """Return current chaos config for all services."""
    result = {svc: _serialize_chaos(cfg) for svc, cfg in chaos_configs.items()}
    return JSONResponse(content=result)


async def _handle_set_chaos(
    request: Request, chaos_configs: dict[str, AwsChaosConfig]
) -> JSONResponse:
    """Update chaos config for one or more services."""
    body = await request.json()
    updated: list[str] = []
    for svc, overrides in body.items():
        if svc not in chaos_configs:
            continue
        _apply_chaos_overrides(chaos_configs[svc], overrides)
        updated.append(svc)
    result = {svc: _serialize_chaos(chaos_configs[svc]) for svc in updated}
    return JSONResponse(content={"updated": updated, "chaos": result})


def _serialize_chaos(cfg: AwsChaosConfig) -> dict[str, Any]:
    """Serialize an AwsChaosConfig to a JSON-safe dict."""
    return {
        "enabled": cfg.enabled,
        "error_rate": cfg.error_rate,
        "latency_min_ms": cfg.latency_min_ms,
        "latency_max_ms": cfg.latency_max_ms,
        "errors": [{"type": e.type, "message": e.message, "weight": e.weight} for e in cfg.errors],
        "connection_reset_rate": cfg.connection_reset_rate,
        "timeout_rate": cfg.timeout_rate,
    }


def _apply_chaos_overrides(cfg: AwsChaosConfig, overrides: dict[str, Any]) -> None:
    """Apply partial overrides to an existing AwsChaosConfig in place."""
    if "enabled" in overrides:
        cfg.enabled = bool(overrides["enabled"])
    if "error_rate" in overrides:
        cfg.error_rate = float(overrides["error_rate"])
    if "latency_min_ms" in overrides:
        cfg.latency_min_ms = int(overrides["latency_min_ms"])
    if "latency_max_ms" in overrides:
        cfg.latency_max_ms = int(overrides["latency_max_ms"])
    if "connection_reset_rate" in overrides:
        cfg.connection_reset_rate = float(overrides["connection_reset_rate"])
    if "timeout_rate" in overrides:
        cfg.timeout_rate = float(overrides["timeout_rate"])
    if "errors" in overrides:
        cfg.errors = parse_chaos_config({"errors": overrides["errors"]}).errors


# ---------------------------------------------------------------------------
# AWS Mock helpers
# ---------------------------------------------------------------------------


def _handle_get_aws_mock(mock_configs: dict[str, AwsMockConfig]) -> JSONResponse:
    """Return current AWS mock config for all services."""
    result = {svc: _serialize_aws_mock(cfg) for svc, cfg in mock_configs.items()}
    return JSONResponse(content=result)


async def _handle_set_aws_mock(
    request: Request, mock_configs: dict[str, AwsMockConfig]
) -> JSONResponse:
    """Update AWS mock config for one or more services."""
    body = await request.json()
    updated: list[str] = []
    for svc, overrides in body.items():
        if svc not in mock_configs:
            continue
        _apply_aws_mock_overrides(mock_configs[svc], overrides)
        updated.append(svc)
    result = {svc: _serialize_aws_mock(mock_configs[svc]) for svc in updated}
    return JSONResponse(content={"updated": updated, "aws_mock": result})


def _serialize_aws_mock(cfg: AwsMockConfig) -> dict[str, Any]:
    """Serialize an AwsMockConfig to a JSON-safe dict."""
    return {
        "service": cfg.service,
        "enabled": cfg.enabled,
        "rules": [
            {
                "operation": r.operation,
                "match_headers": r.match_headers,
                "response": {
                    "status": r.response.status,
                    "content_type": r.response.content_type,
                    "delay_ms": r.response.delay_ms,
                },
            }
            for r in cfg.rules
        ],
    }


def _apply_aws_mock_overrides(cfg: AwsMockConfig, overrides: dict[str, Any]) -> None:
    """Apply partial overrides to an existing AwsMockConfig in place."""
    from lws.providers._shared.aws_operation_mock import (  # pylint: disable=import-outside-toplevel
        parse_mock_rule,
    )

    if "enabled" in overrides:
        cfg.enabled = bool(overrides["enabled"])
    if "rules" in overrides:
        cfg.rules = [parse_mock_rule(r) for r in overrides["rules"]]
