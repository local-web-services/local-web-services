"""Chaos management handler functions for the LDK management API."""

from __future__ import annotations

from typing import Any

from fastapi import Request
from fastapi.responses import JSONResponse

from lws.providers._shared.aws_chaos import AwsChaosConfig, parse_chaos_config


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


def _handle_get_chaos_service(
    chaos_configs: dict[str, AwsChaosConfig], service: str
) -> JSONResponse:
    """Return chaos config for a single service."""
    if service not in chaos_configs:
        return JSONResponse(
            status_code=404, content={"error": f"Service {service!r} not found in chaos configs"}
        )
    return JSONResponse(content=_serialize_chaos(chaos_configs[service]))


async def _handle_put_chaos_service(
    request: Request, chaos_configs: dict[str, AwsChaosConfig], service: str
) -> JSONResponse:
    """Set chaos config for a single service (enables chaos automatically)."""
    if service not in chaos_configs:
        return JSONResponse(
            status_code=404, content={"error": f"Service {service!r} not found in chaos configs"}
        )
    body = await request.json()
    _apply_chaos_overrides(chaos_configs[service], {**body, "enabled": True})
    return JSONResponse(content=_serialize_chaos(chaos_configs[service]))


def _handle_delete_chaos_service(
    chaos_configs: dict[str, AwsChaosConfig], service: str
) -> JSONResponse:
    """Reset (disable) chaos config for a single service."""
    if service not in chaos_configs:
        return JSONResponse(
            status_code=404, content={"error": f"Service {service!r} not found in chaos configs"}
        )
    cfg = chaos_configs[service]
    cfg.reset()
    return JSONResponse(content=_serialize_chaos(cfg))


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
