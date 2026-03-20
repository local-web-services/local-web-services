"""Tests for ldk.providers.ecs.health_check."""

from __future__ import annotations

import asyncio
from unittest.mock import AsyncMock, patch

from lws.providers.ecs.health_check import (
    HealthCheckConfig,
    HealthChecker,
    HealthStatus,
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


class TestHealthChecker:
    def test_initial_status_is_unknown(self) -> None:
        cfg = HealthCheckConfig(endpoint="http://localhost:8080/health")
        checker = HealthChecker(cfg)
        assert checker.status == HealthStatus.UNKNOWN, f"Expected {HealthStatus.UNKNOWN!r} but got {checker.status!r}"

    def test_apply_result_healthy(self) -> None:
        cfg = HealthCheckConfig(endpoint="http://localhost:8080/health")
        checker = HealthChecker(cfg)
        checker._apply_result(True)
        assert checker.status == HealthStatus.HEALTHY, f"Expected {HealthStatus.HEALTHY!r} but got {checker.status!r}"

    def test_apply_result_unhealthy_after_retries(self) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:8080/health",
            retries=3,
        )
        checker = HealthChecker(cfg)
        checker._apply_result(False)
        assert checker.status != HealthStatus.UNHEALTHY  # only 1 failure, f"Expected values to differ but both were {checker.status!r}"
        checker._apply_result(False)
        assert checker.status != HealthStatus.UNHEALTHY  # only 2 failures, f"Expected values to differ but both were {checker.status!r}"
        checker._apply_result(False)
        assert checker.status == HealthStatus.UNHEALTHY  # 3 failures, "Expected assertion to pass"

    def test_apply_result_resets_on_success(self) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:8080/health",
            retries=3,
        )
        checker = HealthChecker(cfg)
        checker._apply_result(False)
        checker._apply_result(False)
        checker._apply_result(True)  # reset
        assert checker.status == HealthStatus.HEALTHY, f"Expected {HealthStatus.HEALTHY!r} but got {checker.status!r}"
        assert checker._consecutive_failures == 0, f"Expected {0!r} but got {checker._consecutive_failures!r}"

    @patch(
        "lws.providers.ecs.health_check._http_get_ok",
        new_callable=AsyncMock,
        return_value=True,
    )
    async def test_start_creates_polling_task(self, _fake_get: AsyncMock) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:8080/health",
            interval=0.01,
            start_period=0.0,
        )
        checker = HealthChecker(cfg)
        checker.start()
        # Let one poll cycle run
        await asyncio.sleep(0.05)
        await checker.stop()
        assert checker.status == HealthStatus.UNKNOWN  # reset after stop, "Expected assertion to pass"

    async def test_stop_without_start_is_safe(self) -> None:
        cfg = HealthCheckConfig(endpoint="http://localhost:8080/health")
        checker = HealthChecker(cfg)
        await checker.stop()  # should not raise

    @patch(
        "lws.providers.ecs.health_check._http_get_ok",
        new_callable=AsyncMock,
        return_value=False,
    )
    async def test_poll_marks_unhealthy(self, _fake_get: AsyncMock) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:8080/health",
            interval=0.01,
            retries=1,
            start_period=0.0,
        )
        checker = HealthChecker(cfg)
        checker.start()
        await asyncio.sleep(0.05)
        assert checker.status == HealthStatus.UNHEALTHY, f"Expected {HealthStatus.UNHEALTHY!r} but got {checker.status!r}"
        await checker.stop()

    async def test_start_is_idempotent(self) -> None:
        cfg = HealthCheckConfig(
            endpoint="http://localhost:8080/health",
            interval=60.0,
        )
        checker = HealthChecker(cfg)
        checker.start()
        first_task = checker._task
        checker.start()  # second call should be a no-op
        assert checker._task is first_task, "Expected value to be truthy"
        # Clean up
        await checker.stop()
