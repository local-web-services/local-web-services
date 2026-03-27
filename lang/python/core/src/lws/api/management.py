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

from lws.api._management_aws_fake import (
    _handle_get_aws_fake,
    _handle_set_aws_fake,
)
from lws.api._management_capacity import (
    _register_capacity_routes,
)
from lws.api._management_chaos import (
    _handle_delete_chaos_service,
    _handle_get_chaos,
    _handle_get_chaos_service,
    _handle_put_chaos_service,
    _handle_set_chaos,
)
from lws.api._management_fake import (
    _handle_add_route,
    _handle_create_fake_server,
    _handle_delete_fake_server,
    _handle_get_fake_server,
    _handle_list_fake_servers,
    _handle_remove_route,
    _handle_set_fake_server_chaos,
)
from lws.api._management_iam_auth import (
    _handle_get_iam_auth,
    _handle_set_iam_auth,
)
from lws.api._management_lifecycle import (
    _register_lifecycle_routes,
)
from lws.api.gui import get_dashboard_html
from lws.interfaces.provider import Provider
from lws.logging.logger import get_logger, get_ws_handler
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_chaos import AwsChaosConfig
from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig
from lws.providers._shared.aws_operation_fake import AwsFakeConfig
from lws.runtime.orchestrator import Orchestrator

_logger = get_logger("ldk.management")


class StatusResponse(BaseModel):
    """Response body for the status endpoint."""

    running: bool
    providers: list[dict[str, Any]]


def _reset_chaos_configs(chaos_configs: dict[str, AwsChaosConfig] | None) -> None:
    """Reset all chaos configs to their default (disabled) state."""
    if chaos_configs is None:
        return
    for cfg in chaos_configs.values():
        cfg.reset()


def _reset_lifecycle_configs(lifecycle_configs: dict[str, ResourceLifecycleConfig] | None) -> None:
    """Reset all lifecycle configs to their default (enabled, zero-dwell) state."""
    if lifecycle_configs is None:
        return
    for cfg in lifecycle_configs.values():
        cfg.enabled = True
        cfg.create_dwell_ms = 0
        cfg.delete_dwell_ms = 0
        cfg.modify_dwell_ms = 0
        cfg.reset_all_trackers()


async def _handle_reset(
    providers_map: dict[str, Provider],
    chaos_configs: dict[str, AwsChaosConfig] | None = None,
    aws_fake_configs: dict[str, AwsFakeConfig] | None = None,
    lifecycle_configs: dict[str, ResourceLifecycleConfig] | None = None,
    capacity_configs: dict[str, AwsCapacityConfig] | None = None,
) -> JSONResponse:
    """Reset all provider data and state, including chaos, fake, lifecycle, and capacity configs."""
    _logger.info("Reset requested via management API")
    reset_count = 0

    for provider in providers_map.values():
        if hasattr(provider, "reset"):
            try:
                await provider.reset()
                reset_count += 1
            except Exception as exc:
                _logger.error("Error resetting %s: %s", provider.name, exc)

    _reset_chaos_configs(chaos_configs)

    if aws_fake_configs is not None:
        for cfg in aws_fake_configs.values():
            cfg.rules = []

    _reset_lifecycle_configs(lifecycle_configs)

    if capacity_configs is not None:
        for cfg in capacity_configs.values():
            cfg.reset()

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
    aws_fake_configs: dict[str, AwsFakeConfig] | None = None,
    iam_auth_bundle: Any | None = None,
    lifecycle_configs: dict[str, ResourceLifecycleConfig] | None = None,
    capacity_configs: dict[str, AwsCapacityConfig] | None = None,
    fake_provider: Any | None = None,
) -> APIRouter:
    """Create a management API router.

    Args:
        orchestrator: The running ``Orchestrator`` instance.
        providers: Optional map of all providers for status reporting.
        resource_metadata: Pre-built resource metadata for the ``/_ldk/resources`` endpoint.
        chaos_configs: Map of service name to mutable ``AwsChaosConfig`` for runtime updates.
        aws_fake_configs: Map of service name to mutable ``AwsFakeConfig`` for runtime updates.
        iam_auth_bundle: Optional IAM auth bundle for runtime IAM auth management.
        lifecycle_configs: Map of service name to mutable ``ResourceLifecycleConfig``
            for runtime updates.
        capacity_configs: Map of service name to mutable ``AwsCapacityConfig`` for runtime updates.
        fake_provider: Optional ``FakeServerProvider`` for runtime fake server management.

    Returns:
        A FastAPI ``APIRouter`` to be included in the main application.
    """
    router = APIRouter(prefix="/_ldk", tags=["management"])
    all_providers = providers or orchestrator.providers
    _resource_metadata = resource_metadata or {}
    _chaos_configs = chaos_configs or {}
    _aws_fake_configs = aws_fake_configs or {}
    _lifecycle_configs = lifecycle_configs or {}
    _capacity_configs = capacity_configs or {}

    _register_core_routes(
        router,
        orchestrator,
        all_providers,
        _resource_metadata,
        _chaos_configs,
        _aws_fake_configs,
        _lifecycle_configs,
        _capacity_configs,
    )
    _register_chaos_routes(router, _chaos_configs)
    _register_iam_auth_routes(router, iam_auth_bundle)
    _register_function_url_routes(router, all_providers)
    _register_aws_fake_routes(router, _aws_fake_configs)
    _register_fake_server_routes(router, fake_provider)
    _register_lifecycle_routes(router, _lifecycle_configs)
    _register_capacity_routes(router, _capacity_configs)

    return router


def _register_core_routes(
    router: APIRouter,
    orchestrator: Orchestrator,
    all_providers: dict[str, Any],
    resource_metadata: dict[str, Any],
    chaos_configs: dict[str, AwsChaosConfig] | None = None,
    aws_fake_configs: dict[str, AwsFakeConfig] | None = None,
    lifecycle_configs: dict[str, ResourceLifecycleConfig] | None = None,
    capacity_configs: dict[str, AwsCapacityConfig] | None = None,
) -> None:
    """Register core management routes (reset, status, resources, gui, ws, shutdown, proxy)."""

    @router.post("/reset")
    async def reset_state() -> JSONResponse:
        return await _handle_reset(
            all_providers, chaos_configs, aws_fake_configs, lifecycle_configs, capacity_configs
        )

    @router.get("/status")
    async def get_status() -> JSONResponse:
        return await _handle_status(orchestrator, all_providers)

    @router.get("/resources")
    async def get_resources() -> JSONResponse:
        return JSONResponse(content=resource_metadata)

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


def _register_chaos_routes(
    router: APIRouter,
    chaos_configs: dict[str, AwsChaosConfig],
) -> None:
    """Register chaos management routes."""

    @router.get("/chaos")
    async def get_chaos() -> JSONResponse:
        return _handle_get_chaos(chaos_configs)

    @router.post("/chaos")
    async def set_chaos(request: Request) -> JSONResponse:
        return await _handle_set_chaos(request, chaos_configs)

    @router.get("/chaos/{service}")
    async def get_chaos_service(service: str) -> JSONResponse:
        return _handle_get_chaos_service(chaos_configs, service)

    @router.put("/chaos/{service}")
    async def put_chaos_service(service: str, request: Request) -> JSONResponse:
        return await _handle_put_chaos_service(request, chaos_configs, service)

    @router.delete("/chaos/{service}")
    async def delete_chaos_service(service: str) -> JSONResponse:
        return _handle_delete_chaos_service(chaos_configs, service)


def _register_iam_auth_routes(
    router: APIRouter,
    iam_auth_bundle: Any | None,
) -> None:
    """Register IAM auth management routes."""
    _iam_auth = iam_auth_bundle

    @router.get("/iam-auth")
    async def get_iam_auth() -> JSONResponse:
        return _handle_get_iam_auth(_iam_auth)

    @router.post("/iam-auth")
    async def post_iam_auth(request: Request) -> JSONResponse:
        return await _handle_set_iam_auth(request, _iam_auth)


def _register_function_url_routes(
    router: APIRouter,
    providers_map: dict[str, Any],
) -> None:
    """Register Function URL discovery routes on the router."""

    @router.get("/function-urls")
    async def get_function_urls() -> JSONResponse:
        return _handle_get_function_urls(providers_map)


def _handle_get_function_urls(providers_map: dict[str, Any]) -> JSONResponse:
    """Return current Function URL port mappings from any Lambda registry."""
    result: dict[str, Any] = {"FunctionUrls": []}
    for prov in providers_map.values():
        if hasattr(prov, "function_name") and hasattr(prov, "port"):
            result["FunctionUrls"].append(
                {
                    "FunctionName": prov.function_name,
                    "FunctionUrl": f"http://localhost:{prov.port}/",
                    "Port": prov.port,
                }
            )
    return JSONResponse(content=result)


def _register_aws_fake_routes(
    router: APIRouter,
    aws_fake_configs: dict[str, AwsFakeConfig],
) -> None:
    """Register AWS fake management routes on the router."""

    @router.get("/aws-fake")
    async def get_aws_fake() -> JSONResponse:
        return _handle_get_aws_fake(aws_fake_configs)

    @router.post("/aws-fake")
    async def set_aws_fake(request: Request) -> JSONResponse:
        return await _handle_set_aws_fake(request, aws_fake_configs)


def _register_fake_server_routes(
    router: APIRouter,
    fake_provider: Any | None,
) -> None:
    """Register fake server management routes on the router."""
    if fake_provider is None:
        return

    @router.get("/fake")
    async def list_fake_servers() -> JSONResponse:
        return _handle_list_fake_servers(fake_provider)

    @router.post("/fake")
    async def create_fake_server(request: Request) -> JSONResponse:
        return await _handle_create_fake_server(request, fake_provider)

    @router.get("/fake/{name}")
    async def get_fake_server(name: str) -> JSONResponse:
        return _handle_get_fake_server(fake_provider, name)

    @router.delete("/fake/{name}")
    async def delete_fake_server(name: str) -> JSONResponse:
        return await _handle_delete_fake_server(fake_provider, name)

    @router.post("/fake/{name}/routes")
    async def add_fake_route(name: str, request: Request) -> JSONResponse:
        return await _handle_add_route(request, fake_provider, name)

    @router.delete("/fake/{name}/routes")
    async def remove_fake_route(name: str, request: Request) -> JSONResponse:
        return await _handle_remove_route(request, fake_provider, name)

    @router.post("/fake/{name}/chaos")
    async def set_fake_server_chaos(name: str, request: Request) -> JSONResponse:
        return await _handle_set_fake_server_chaos(request, fake_provider, name)
