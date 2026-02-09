"""Tests for ldk.providers.ecs.health_check."""

from __future__ import annotations

from lws.providers.ecs.health_check import (
    _http_get_ok,
)

# ---------------------------------------------------------------------------
# HealthCheckConfig tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# HealthChecker tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# _http_get_ok tests
# ---------------------------------------------------------------------------


class TestHttpGetOk:
    async def test_returns_false_on_connection_error(self) -> None:
        # Port 1 is almost certainly not listening
        result = await _http_get_ok("http://localhost:1/health", timeout=0.1)
        assert result is False

    async def test_returns_false_on_invalid_url(self) -> None:
        result = await _http_get_ok("not-a-url", timeout=0.1)
        assert result is False
