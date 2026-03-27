"""Tests for API Gateway stage throttle enforcement logic."""

from __future__ import annotations

import pytest

from lws.providers.apigateway._apigateway_v1 import ApiGatewayManagementRouter


class TestStageThrottleEnforcement:
    def test_check_stage_throttle_returns_none_when_no_limit(self) -> None:
        # Arrange
        router = ApiGatewayManagementRouter()
        api = router._state.create_rest_api("test-api")  # pylint: disable=protected-access
        api.stages["prod"] = {
            "stageName": "prod",
            "defaultRouteSettings": {"throttlingBurstLimit": None},
            "_request_count": 0,
        }

        # Act
        actual_result = router._check_stage_throttle(  # pylint: disable=protected-access
            api, "prod"
        )

        # Assert
        expected_result = None
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    def test_check_stage_throttle_returns_429_when_limit_exceeded(self) -> None:
        # Arrange
        router = ApiGatewayManagementRouter()
        api = router._state.create_rest_api("throttle-test-api")  # pylint: disable=protected-access
        burst_limit = 1
        api.stages["prod"] = {
            "stageName": "prod",
            "defaultRouteSettings": {"throttlingBurstLimit": burst_limit},
            "_request_count": burst_limit,
        }

        # Act
        actual_result = router._check_stage_throttle(  # pylint: disable=protected-access
            api, "prod"
        )

        # Assert
        expected_status = 429
        assert actual_result is not None, "Expected a 429 response, got None"
        actual_status = actual_result.status_code
        assert (
            actual_status == expected_status
        ), f"Expected {expected_status!r} but got {actual_status!r}"

    def test_check_stage_throttle_increments_request_count(self) -> None:
        # Arrange
        router = ApiGatewayManagementRouter()
        api = router._state.create_rest_api("count-test-api")  # pylint: disable=protected-access
        api.stages["prod"] = {
            "stageName": "prod",
            "defaultRouteSettings": {"throttlingBurstLimit": 10},
            "_request_count": 0,
        }
        expected_count_after = 1

        # Act
        router._check_stage_throttle(api, "prod")  # pylint: disable=protected-access

        # Assert
        actual_count = api.stages["prod"]["_request_count"]
        assert (
            actual_count == expected_count_after
        ), f"Expected {expected_count_after!r} but got {actual_count!r}"

    @pytest.mark.asyncio
    async def test_check_stage_throttle_returns_none_for_missing_stage(self) -> None:
        # Arrange
        router = ApiGatewayManagementRouter()
        api = router._state.create_rest_api("missing-stage-api")  # pylint: disable=protected-access
        expected_result = None

        # Act
        actual_result = router._check_stage_throttle(  # pylint: disable=protected-access
            api, "nonexistent-stage"
        )

        # Assert
        assert (
            actual_result == expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"
