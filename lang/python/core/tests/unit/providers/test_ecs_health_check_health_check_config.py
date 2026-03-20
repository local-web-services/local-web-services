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
        assert cfg.interval == 30.0, f"Expected {30.0!r} but got {cfg.interval!r}"
        assert cfg.timeout == 5.0, f"Expected {5.0!r} but got {cfg.timeout!r}"
        assert cfg.retries == 3, f"Expected {3!r} but got {cfg.retries!r}"
        assert cfg.start_period == 0.0, f"Expected {0.0!r} but got {cfg.start_period!r}"

    def test_custom_values(self) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:3000/ping",
            interval=10.0,
            timeout=2.0,
            retries=5,
            start_period=15.0,
        )
        assert cfg.interval == 10.0, f"Expected {10.0!r} but got {cfg.interval!r}"
        assert cfg.retries == 5, f"Expected {5!r} but got {cfg.retries!r}"
