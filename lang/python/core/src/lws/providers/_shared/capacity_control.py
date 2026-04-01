"""Control plane router for setting capacity limits in tests.

Exposes ``GET /_lws/control/{service}/capacity`` to read current config,
``PUT /_lws/control/{service}/capacity`` with body ``{"slots": 0|null}``
to set or exhaust capacity, and ``DELETE`` on the same URL to reset to
unlimited.
"""

from __future__ import annotations

from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse

from lws.providers._shared.aws_capacity import AwsCapacityConfig


def create_capacity_control_router(
    capacity_configs: dict[str, AwsCapacityConfig],
) -> APIRouter:
    """Create an APIRouter with capacity control endpoints.

    Args:
        capacity_configs: Mapping of service name to mutable ``AwsCapacityConfig``.

    Returns:
        An ``APIRouter`` ready to include in a FastAPI app.
    """
    router = APIRouter()

    @router.get("/_lws/control/{service}/capacity")
    async def get_capacity(service: str) -> JSONResponse:
        if service not in capacity_configs:
            return JSONResponse(
                content={"error": f"No capacity config registered for service: {service}"},
                status_code=404,
            )
        cfg = capacity_configs[service]
        return JSONResponse(content={"service": service, "slots": cfg.slots})

    @router.put("/_lws/control/{service}/capacity")
    async def put_capacity(service: str, request: Request) -> JSONResponse:
        if service not in capacity_configs:
            return JSONResponse(
                content={"error": f"No capacity config registered for service: {service}"},
                status_code=404,
            )
        body = await request.json()
        if "slots" not in body:
            return JSONResponse(
                content={"error": "Request body must include 'slots'"},
                status_code=400,
            )
        cfg = capacity_configs[service]
        raw = body["slots"]
        cfg.slots = int(raw) if raw is not None else None
        return JSONResponse(content={"service": service, "slots": cfg.slots})

    @router.delete("/_lws/control/{service}/capacity")
    async def delete_capacity(service: str) -> JSONResponse:
        if service not in capacity_configs:
            return JSONResponse(
                content={"error": f"No capacity config registered for service: {service}"},
                status_code=404,
            )
        cfg = capacity_configs[service]
        cfg.reset()
        return JSONResponse(content={"service": service, "slots": cfg.slots})

    return router
