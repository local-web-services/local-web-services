"""Tests for ServiceTaskBridge SSM service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeSsmAdapter


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeSsm:
    """SSM service integration dispatching."""

    async def test_get_parameter_returns_response(self) -> None:
        # Arrange
        expected_name = "/app/config/key"
        ssm = FakeSsmAdapter()
        bridge = make_bridge(ssm=ssm)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::ssm:getParameter",
            {"Name": expected_name},
        )

        # Assert
        actual_name = result["Parameter"]["Name"]
        assert actual_name == expected_name

    async def test_get_parameter_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No SSM provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::ssm:getParameter", {})
