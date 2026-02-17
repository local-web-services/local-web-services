"""Chaos engineering middleware for mock servers.

Injects errors, latency, and connection resets based on ChaosConfig.
"""

from __future__ import annotations

import asyncio
import random

from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.requests import Request
from starlette.responses import JSONResponse, Response

from lws.providers.mockserver.models import ChaosConfig


class ChaosMiddleware(BaseHTTPMiddleware):
    """Starlette middleware that injects chaos into mock server responses."""

    def __init__(self, app, chaos_config: ChaosConfig) -> None:  # noqa: ANN001
        super().__init__(app)
        self.chaos = chaos_config

    async def dispatch(self, request: Request, call_next: RequestResponseEndpoint) -> Response:
        """Apply chaos rules before forwarding the request."""
        if not self.chaos.enabled:
            return await call_next(request)

        # Skip chaos for management endpoints
        if request.url.path.startswith("/_mock/"):
            return await call_next(request)

        # Connection reset
        reset_rate = self.chaos.connection_reset_rate
        if reset_rate > 0 and random.random() < reset_rate:
            raise ConnectionResetError("chaos: connection reset")

        # Timeout simulation
        if self.chaos.timeout_rate > 0 and random.random() < self.chaos.timeout_rate:
            await asyncio.sleep(300)
            return JSONResponse(status_code=504, content={"error": "chaos_timeout"})

        # Latency injection
        if self.chaos.latency_max_ms > 0:
            delay = random.uniform(self.chaos.latency_min_ms, self.chaos.latency_max_ms)
            await asyncio.sleep(delay / 1000.0)

        # Error rate injection
        if self.chaos.error_rate > 0 and random.random() < self.chaos.error_rate:
            status = _pick_error_status(self.chaos)
            return JSONResponse(
                status_code=status,
                content={"error": "chaos_injected", "status": status},
            )

        return await call_next(request)


def _pick_error_status(chaos: ChaosConfig) -> int:
    """Pick an error status code based on weighted status_codes config."""
    if not chaos.status_codes:
        return 500
    roll = random.random()
    cumulative = 0.0
    for sc in chaos.status_codes:
        cumulative += sc.get("weight", 0.0)
        if roll < cumulative:
            return sc.get("status", 500)
    return 500
