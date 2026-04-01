"""Tests for ServiceTaskBridge capacity enforcement on SSM dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeExhaustedCapacity, FakeSsmAdapter, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestSsmCapacity:
    """SSM dispatch is blocked when capacity is exhausted."""

    async def test_get_parameter_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        ssm = FakeSsmAdapter()
        bridge = make_bridge(ssm=ssm, ssm_capacity=FakeExhaustedCapacity())
        expected_error = "SSM capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::ssm:getParameter",
                {"Name": "/my/param"},
            )

    async def test_get_parameter_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        ssm = FakeSsmAdapter()
        bridge = make_bridge(ssm=ssm, ssm_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::ssm:getParameter",
            {"Name": "/my/param"},
        )

        # Assert
        actual_param = result.get("Parameter")
        assert actual_param is not None, "Expected a Parameter field in the response"
