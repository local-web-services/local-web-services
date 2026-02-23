"""FastAPI app factory for REST mock servers."""

from __future__ import annotations

import asyncio
import json
from typing import Any

from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

from lws.logging.logger import LdkLogger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers.mockserver.engine import RouteMatchEngine
from lws.providers.mockserver.models import ChaosConfig, MockServerConfig


def create_mockserver_app(config: MockServerConfig) -> FastAPI:
    """Create a FastAPI application that serves mock responses for the given config."""
    app = FastAPI(title=f"Mock: {config.name}", description=config.description)
    engine = RouteMatchEngine(config.routes)

    # Store mutable state on the app for runtime updates
    app.state.config = config
    app.state.engine = engine
    app.state.chaos = config.chaos

    # Add request logging middleware
    logger = LdkLogger(f"mock.{config.name}")
    app.add_middleware(
        RequestLoggingMiddleware,
        logger=logger,
        service_name=f"mock-{config.name}",
    )

    _register_management_routes(app)
    _register_catch_all(app)

    return app


def _register_management_routes(app: FastAPI) -> None:
    """Register /_mock/* management endpoints."""

    @app.get("/_mock/config")
    async def get_config() -> dict[str, Any]:
        cfg: MockServerConfig = app.state.config
        return {
            "name": cfg.name,
            "description": cfg.description,
            "protocol": cfg.protocol,
            "route_count": len(cfg.routes),
            "chaos": {
                "enabled": cfg.chaos.enabled,
                "error_rate": cfg.chaos.error_rate,
            },
        }

    @app.post("/_mock/chaos")
    async def set_chaos(request: Request) -> dict[str, Any]:
        body = await request.json()
        chaos: ChaosConfig = app.state.chaos
        if "enabled" in body:
            chaos.enabled = body["enabled"]
        if "error_rate" in body:
            chaos.error_rate = float(body["error_rate"])
        if "latency_min_ms" in body:
            chaos.latency_min_ms = int(body["latency_min_ms"])
        if "latency_max_ms" in body:
            chaos.latency_max_ms = int(body["latency_max_ms"])
        return {"chaos": {"enabled": chaos.enabled, "error_rate": chaos.error_rate}}


def _register_catch_all(app: FastAPI) -> None:
    """Register the catch-all route handler."""

    @app.api_route(
        "/{path:path}",
        methods=["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    )
    async def catch_all(request: Request, path: str) -> JSONResponse:
        """Match the request against configured routes."""
        request_path = f"/{path}"
        method = request.method
        headers = dict(request.headers)
        query_params = dict(request.query_params)

        body = await _parse_request_body(request, method)

        # Apply chaos if enabled
        chaos_cfg: ChaosConfig = app.state.chaos
        if chaos_cfg.enabled:
            chaos_response = await _apply_chaos(chaos_cfg)
            if chaos_response is not None:
                return chaos_response

        current_engine: RouteMatchEngine = app.state.engine
        result = current_engine.match(
            method=method,
            path=request_path,
            headers=headers,
            query_params=query_params,
            body=body,
        )

        if result is None:
            return JSONResponse(
                status_code=404,
                content={"error": "no matching route", "path": request_path, "method": method},
            )

        response, _path_params = result

        if response.delay_ms > 0:
            await asyncio.sleep(response.delay_ms / 1000.0)

        return JSONResponse(
            status_code=response.status,
            content=response.body,
            headers=dict(response.headers),
        )


async def _parse_request_body(request: Request, method: str) -> Any | None:
    """Parse JSON body from request if applicable."""
    if method not in ("POST", "PUT", "PATCH"):
        return None
    try:
        raw_body = await request.body()
        if raw_body:
            return json.loads(raw_body)
    except (json.JSONDecodeError, ValueError):
        pass
    return None


async def _apply_chaos(chaos: ChaosConfig) -> JSONResponse | None:
    """Apply chaos rules and return an error response if triggered, else None."""
    import random  # pylint: disable=import-outside-toplevel

    # Latency injection
    if chaos.latency_max_ms > 0:
        delay = random.uniform(chaos.latency_min_ms, chaos.latency_max_ms)
        await asyncio.sleep(delay / 1000.0)

    # Error rate injection
    if chaos.error_rate > 0 and random.random() < chaos.error_rate:
        status = 500
        if chaos.status_codes:
            roll = random.random()
            cumulative = 0.0
            for sc in chaos.status_codes:
                cumulative += sc.get("weight", 0.0)
                if roll < cumulative:
                    status = sc.get("status", 500)
                    break
        return JSONResponse(
            status_code=status,
            content={"error": "chaos_injected", "status": status},
        )

    return None
