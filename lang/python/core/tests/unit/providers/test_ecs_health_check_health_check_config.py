"""Tests for ldk.providers.ecs.health_check."""

from __future__ import annotations

from lws.providers.ecs.health_check import (
    HealthCheckConfig,
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


class TestHealthCheckConfig:
    def test_defaults(self) -> None:
        cfg = HealthCheckConfig(endpoint="http://localhost:8080/health")
        assert cfg.interval == 30.0
        assert cfg.timeout == 5.0
        assert cfg.retries == 3
        assert cfg.start_period == 0.0

    def test_custom_values(self) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:3000/ping",
            interval=10.0,
            timeout=2.0,
            retries=5,
            start_period=15.0,
        )
        assert cfg.interval == 10.0
        assert cfg.retries == 5
