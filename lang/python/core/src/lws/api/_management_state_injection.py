"""State injection management handler functions for the LDK management API."""

from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse

from lws.providers._shared.async_state_store import AsyncStateStore, resource_state_body


def _register_state_routes(
    router: APIRouter,
    state_store: AsyncStateStore,
    providers: dict[str, Any] | None = None,
) -> None:
    """Register state injection management routes on the router."""
    _providers = providers or {}

    @router.put("/state/{service}/{resource_type}/{resource_id:path}")
    async def inject_state(
        service: str, resource_type: str, resource_id: str, request: Request
    ) -> JSONResponse:
        return await _handle_inject_state(
            service, resource_type, resource_id, request, state_store, _providers
        )

    @router.delete("/state/{service}/{resource_type}/{resource_id:path}")
    async def clear_state(service: str, resource_type: str, resource_id: str) -> JSONResponse:
        return _handle_clear_state(service, resource_type, resource_id, state_store)

    @router.get("/state/{service}/{resource_type}/{resource_id:path}")
    async def get_state(service: str, resource_type: str, resource_id: str) -> JSONResponse:
        return _handle_get_state(service, resource_type, resource_id, state_store)


async def _handle_inject_state(
    service: str,
    resource_type: str,
    resource_id: str,
    request: Request,
    state_store: AsyncStateStore,
    providers: dict[str, Any],
) -> JSONResponse:
    """Set the injected state for a resource."""
    body = await request.json()
    state = body.get("state", "")
    if not state:
        return JSONResponse(status_code=400, content={"error": "state is required"})
    state_store.set(service, resource_type, resource_id, state)
    _dispatch_injection(service, resource_type, resource_id, state, providers)
    return JSONResponse(content=resource_state_body(service, resource_type, resource_id, state))


def _handle_clear_state(
    service: str,
    resource_type: str,
    resource_id: str,
    state_store: AsyncStateStore,
) -> JSONResponse:
    """Clear the injected state for a resource."""
    state_store.clear(service, resource_type, resource_id)
    return JSONResponse(content={"status": "cleared"})


def _handle_get_state(
    service: str,
    resource_type: str,
    resource_id: str,
    state_store: AsyncStateStore,
) -> JSONResponse:
    """Retrieve the injected state for a resource."""
    state = state_store.get(service, resource_type, resource_id)
    if state is None:
        return JSONResponse(status_code=404, content={"error": "No injected state found"})
    return JSONResponse(content=resource_state_body(service, resource_type, resource_id, state))


def _dispatch_injection(
    service: str,
    resource_type: str,
    resource_id: str,
    state: str,
    providers: dict[str, Any],
) -> None:
    """Dispatch state injection to provider-specific handlers."""
    if service == "stepfunctions" and resource_type == "execution":
        sfn = providers.get("stepfunctions")
        if sfn is not None and hasattr(sfn, "inject_execution"):
            sfn.inject_execution(resource_id, state)
