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
) -> APIRouter:
    """Create a management API router.

    Args:
        orchestrator: The running ``Orchestrator`` instance.
        providers: Optional map of all providers for status reporting.
        resource_metadata: Pre-built resource metadata for the ``/_ldk/resources`` endpoint.

    Returns:
        A FastAPI ``APIRouter`` to be included in the main application.
    """
    router = APIRouter(prefix="/_ldk", tags=["management"])
    all_providers = providers or orchestrator.providers
    _resource_metadata = resource_metadata or {}

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

    return router
