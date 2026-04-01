"""Tests for ServiceTaskBridge capacity enforcement on SecretsManager dispatches."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeExhaustedCapacity, FakeSecretsManagerAdapter, FakeUnlimitedCapacity


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestSecretsManagerCapacity:
    """SecretsManager dispatch is blocked when capacity is exhausted."""

    async def test_get_secret_raises_when_capacity_exhausted(self) -> None:
        # Arrange
        sm = FakeSecretsManagerAdapter()
        bridge = make_bridge(secretsmanager=sm, secretsmanager_capacity=FakeExhaustedCapacity())
        expected_error = "SecretsManager capacity is exhausted"

        # Act / Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke(
                "arn:aws:states:::secretsmanager:getSecretValue",
                {"SecretId": "my-secret"},
            )

    async def test_get_secret_succeeds_when_capacity_unlimited(self) -> None:
        # Arrange
        sm = FakeSecretsManagerAdapter()
        bridge = make_bridge(secretsmanager=sm, secretsmanager_capacity=FakeUnlimitedCapacity())

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::secretsmanager:getSecretValue",
            {"SecretId": "my-secret"},
        )

        # Assert
        actual_name = result.get("Name")
        assert actual_name is not None, "Expected a Name field in the response"
