"""Capacity management handler functions for the LDK management API."""

from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse

from lws.providers._shared.aws_capacity import AwsCapacityConfig


def _register_capacity_routes(
    router: APIRouter,
    capacity_configs: dict[str, AwsCapacityConfig],
) -> None:
    """Register capacity management routes on the router."""

    @router.get("/capacity")
    async def get_capacity() -> JSONResponse:
        return _handle_get_capacity(capacity_configs)

    @router.post("/capacity")
    async def set_capacity(request: Request) -> JSONResponse:
        return await _handle_set_capacity(request, capacity_configs)


def _handle_get_capacity(capacity_configs: dict[str, AwsCapacityConfig]) -> JSONResponse:
    """Return current capacity config for all services."""
    result = {svc: _serialize_capacity(cfg) for svc, cfg in capacity_configs.items()}
    return JSONResponse(content=result)


async def _handle_set_capacity(
    request: Request, capacity_configs: dict[str, AwsCapacityConfig]
) -> JSONResponse:
    """Update capacity config for one or more services."""
    body = await request.json()
    updated: list[str] = []
    for svc, overrides in body.items():
        if svc not in capacity_configs:
            continue
        _apply_capacity_overrides(capacity_configs[svc], overrides)
        updated.append(svc)
    result = {svc: _serialize_capacity(capacity_configs[svc]) for svc in updated}
    return JSONResponse(content={"updated": updated, "capacity": result})


def _serialize_capacity(cfg: AwsCapacityConfig) -> dict[str, Any]:
    """Serialize an AwsCapacityConfig to a JSON-safe dict."""
    return {"slots": cfg.slots}


def _apply_capacity_overrides(cfg: AwsCapacityConfig, overrides: dict[str, Any]) -> None:
    """Apply partial overrides to an existing AwsCapacityConfig in place."""
    if "slots" in overrides:
        raw = overrides["slots"]
        cfg.slots = int(raw) if raw is not None else None
