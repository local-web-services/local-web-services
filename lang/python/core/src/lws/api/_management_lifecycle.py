"""Lifecycle management handler functions for the LDK management API."""

from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse

from lws.providers._shared.aws_lifecycle import ResourceLifecycleConfig


def _register_lifecycle_routes(
    router: APIRouter,
    lifecycle_configs: dict[str, ResourceLifecycleConfig],
) -> None:
    """Register lifecycle management routes on the router."""

    @router.get("/lifecycle")
    async def get_lifecycle() -> JSONResponse:
        return _handle_get_lifecycle(lifecycle_configs)

    @router.post("/lifecycle")
    async def set_lifecycle(request: Request) -> JSONResponse:
        return await _handle_set_lifecycle(request, lifecycle_configs)


def _handle_get_lifecycle(lifecycle_configs: dict[str, ResourceLifecycleConfig]) -> JSONResponse:
    """Return current lifecycle config for all services."""
    result = {svc: _serialize_lifecycle(cfg) for svc, cfg in lifecycle_configs.items()}
    return JSONResponse(content=result)


async def _handle_set_lifecycle(
    request: Request, lifecycle_configs: dict[str, ResourceLifecycleConfig]
) -> JSONResponse:
    """Update lifecycle config for one or more services."""
    body = await request.json()
    updated: list[str] = []
    for svc, overrides in body.items():
        if svc not in lifecycle_configs:
            continue
        _apply_lifecycle_overrides(lifecycle_configs[svc], overrides)
        updated.append(svc)
    result = {svc: _serialize_lifecycle(lifecycle_configs[svc]) for svc in updated}
    return JSONResponse(content={"updated": updated, "lifecycle": result})


def _serialize_lifecycle(cfg: ResourceLifecycleConfig) -> dict[str, Any]:
    """Serialize a ResourceLifecycleConfig to a JSON-safe dict."""
    return {
        "enabled": cfg.enabled,
        "create_dwell_ms": cfg.create_dwell_ms,
        "delete_dwell_ms": cfg.delete_dwell_ms,
    }


def _apply_lifecycle_overrides(cfg: ResourceLifecycleConfig, overrides: dict[str, Any]) -> None:
    """Apply partial overrides to an existing ResourceLifecycleConfig in place."""
    if "enabled" in overrides:
        cfg.enabled = bool(overrides["enabled"])
    if "create_dwell_ms" in overrides:
        cfg.create_dwell_ms = int(overrides["create_dwell_ms"])
    if "delete_dwell_ms" in overrides:
        cfg.delete_dwell_ms = int(overrides["delete_dwell_ms"])
