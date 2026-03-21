"""Tests for ServiceTaskBridge SecretsManager service integration dispatch."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge

from ._helpers import FakeSecretsManagerAdapter


def make_bridge(**services) -> ServiceTaskBridge:
    return ServiceTaskBridge(services)


class TestServiceTaskBridgeInvokeSecretsManager:
    """SecretsManager service integration dispatching."""

    async def test_get_secret_value_returns_response(self) -> None:
        # Arrange
        expected_secret_id = "my/secret"
        sm = FakeSecretsManagerAdapter()
        bridge = make_bridge(secretsmanager=sm)

        # Act
        result = await bridge.invoke(
            "arn:aws:states:::secretsmanager:getSecretValue",
            {"SecretId": expected_secret_id},
        )

        # Assert
        actual_name = result["Name"]
        assert actual_name == expected_secret_id

    async def test_get_secret_value_missing_provider_raises(self) -> None:
        # Arrange
        bridge = make_bridge()
        expected_error = "No SecretsManager provider"

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error):
            await bridge.invoke("arn:aws:states:::secretsmanager:getSecretValue", {})
