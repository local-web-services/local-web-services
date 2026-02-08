"""Management API for LDK.

Provides a FastAPI ``APIRouter`` mounted at ``/_ldk/`` that exposes endpoints
for invoking Lambda functions, resetting local state, and querying provider
status -- all without restarting the ``ldk dev`` process.
"""

from __future__ import annotations

import uuid
from typing import Any

from fastapi import APIRouter
from fastapi.responses import JSONResponse
from pydantic import BaseModel

from ldk.interfaces import ICompute, InvocationResult, LambdaContext
from ldk.interfaces.provider import Provider
from ldk.logging.logger import get_logger
from ldk.runtime.orchestrator import Orchestrator

_logger = get_logger("ldk.management")


class InvokeRequest(BaseModel):
    """Request body for the invoke endpoint."""

    function_name: str
    event: dict = {}


class InvokeResponse(BaseModel):
    """Response body for the invoke endpoint."""

    payload: dict | None = None
    error: str | None = None


class StatusResponse(BaseModel):
    """Response body for the status endpoint."""

    running: bool
    providers: list[dict[str, Any]]


async def _handle_invoke(
    request: InvokeRequest,
    compute_providers: dict[str, ICompute],
) -> JSONResponse:
    """Invoke a Lambda function by name with the given event."""
    compute = compute_providers.get(request.function_name)
    if compute is None:
        return JSONResponse(
            status_code=404,
            content={"error": f"Function not found: {request.function_name}"},
        )

    request_id = str(uuid.uuid4())
    context = LambdaContext(
        function_name=request.function_name,
        memory_limit_in_mb=128,
        timeout_seconds=30,
        aws_request_id=request_id,
        invoked_function_arn=(
            f"arn:aws:lambda:us-east-1:000000000000:function:{request.function_name}"
        ),
    )

    try:
        result: InvocationResult = await compute.invoke(request.event, context)
        _logger.info(
            "Invoked %s via management API -> %s",
            request.function_name,
            "OK" if result.error is None else "ERROR",
        )
        return JSONResponse(
            content={"payload": result.payload, "error": result.error},
        )
    except Exception as exc:
        _logger.error("Management invoke failed: %s", exc)
        return JSONResponse(status_code=500, content={"error": str(exc)})


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


def create_management_router(
    orchestrator: Orchestrator,
    compute_providers: dict[str, ICompute],
    providers: dict[str, Provider] | None = None,
    resource_metadata: dict[str, Any] | None = None,
) -> APIRouter:
    """Create a management API router.

    Args:
        orchestrator: The running ``Orchestrator`` instance.
        compute_providers: Map of function name to ``ICompute`` provider.
        providers: Optional map of all providers for status reporting.
        resource_metadata: Pre-built resource metadata for the ``/_ldk/resources`` endpoint.

    Returns:
        A FastAPI ``APIRouter`` to be included in the main application.
    """
    router = APIRouter(prefix="/_ldk", tags=["management"])
    all_providers = providers or orchestrator._providers
    _resource_metadata = resource_metadata or {}

    @router.post("/invoke")
    async def invoke_function(request: InvokeRequest) -> JSONResponse:
        return await _handle_invoke(request, compute_providers)

    @router.post("/reset")
    async def reset_state() -> JSONResponse:
        return await _handle_reset(all_providers)

    @router.get("/status")
    async def get_status() -> JSONResponse:
        return await _handle_status(orchestrator, all_providers)

    @router.get("/resources")
    async def get_resources() -> JSONResponse:
        return JSONResponse(content=_resource_metadata)

    return router
