"""Fake server management handler functions for the LDK management API."""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

from fastapi import Request
from fastapi.responses import JSONResponse

if TYPE_CHECKING:
    from lws.providers.fakeserver.provider import FakeServerProvider


def _serialize_server(child: Any) -> dict[str, Any]:
    """Serialize a fake server child to a JSON-safe dict."""
    return {
        "name": child.config.name,
        "port": child.port,
        "protocol": child.config.protocol,
        "description": child.config.description,
        "route_count": len(child.config.routes),
        "chaos_enabled": child.config.chaos.enabled,
    }


def _handle_list_fake_servers(fake_provider: FakeServerProvider) -> JSONResponse:
    """Return info about all running fake servers."""
    servers = [_serialize_server(c) for c in fake_provider.children.values()]
    return JSONResponse(content={"servers": servers})


async def _handle_create_fake_server(
    request: Request, fake_provider: FakeServerProvider
) -> JSONResponse:
    """Create a new in-memory fake server."""
    body = await request.json()
    name = body.get("name")
    if not name:
        return JSONResponse(status_code=400, content={"error": "name is required"})
    protocol = body.get("protocol", "rest")
    description = body.get("description", "")
    try:
        info = await fake_provider.create_server_in_memory(name, protocol, description)
    except ValueError as exc:
        return JSONResponse(status_code=409, content={"error": str(exc)})
    return JSONResponse(status_code=201, content=info)


def _handle_get_fake_server(fake_provider: FakeServerProvider, name: str) -> JSONResponse:
    """Return info about a single fake server."""
    child = fake_provider.children.get(name)
    if child is None:
        return JSONResponse(status_code=404, content={"error": f"Fake server '{name}' not found"})
    return JSONResponse(content=_serialize_server(child))


async def _handle_delete_fake_server(fake_provider: FakeServerProvider, name: str) -> JSONResponse:
    """Delete an in-memory fake server."""
    try:
        await fake_provider.delete_server_in_memory(name)
    except KeyError as exc:
        return JSONResponse(status_code=404, content={"error": str(exc)})
    return JSONResponse(content={"deleted": name})


async def _handle_add_route(
    request: Request, fake_provider: FakeServerProvider, name: str
) -> JSONResponse:
    """Add a route to a fake server."""
    body = await request.json()
    method = body.get("method", "GET")
    path = body.get("path")
    if not path:
        return JSONResponse(status_code=400, content={"error": "path is required"})
    status = int(body.get("status", 200))
    response_body = body.get("body")
    headers = body.get("headers")
    try:
        fake_provider.add_route_in_memory(name, method, path, status, response_body, headers)
    except KeyError as exc:
        return JSONResponse(status_code=404, content={"error": str(exc)})
    except ValueError as exc:
        return JSONResponse(status_code=409, content={"error": str(exc)})
    return JSONResponse(
        status_code=201,
        content={"added": {"method": method.upper(), "path": path, "status": status}},
    )


async def _handle_remove_route(
    request: Request, fake_provider: FakeServerProvider, name: str
) -> JSONResponse:
    """Remove a route from a fake server."""
    body = await request.json()
    method = body.get("method", "GET")
    path = body.get("path")
    if not path:
        return JSONResponse(status_code=400, content={"error": "path is required"})
    try:
        fake_provider.remove_route_in_memory(name, method, path)
    except KeyError as exc:
        return JSONResponse(status_code=404, content={"error": str(exc)})
    return JSONResponse(content={"removed": {"method": method.upper(), "path": path}})


async def _handle_set_fake_server_chaos(
    request: Request, fake_provider: FakeServerProvider, name: str
) -> JSONResponse:
    """Configure chaos on a fake server."""
    child = fake_provider.children.get(name)
    if child is None:
        return JSONResponse(status_code=404, content={"error": f"Fake server '{name}' not found"})
    body = await request.json()
    chaos = child.config.chaos
    chaos.apply_overrides(body)
    child.reload(child.config)
    return JSONResponse(
        content={
            "name": name,
            "chaos": {
                "enabled": chaos.enabled,
                "error_rate": chaos.error_rate,
                "latency_min_ms": chaos.latency_min_ms,
                "latency_max_ms": chaos.latency_max_ms,
            },
        }
    )
