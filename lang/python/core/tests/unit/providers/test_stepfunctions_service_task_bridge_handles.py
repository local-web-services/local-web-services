"""Tests for ServiceTaskBridge.handles() — ARN routing decisions."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge


@pytest.fixture()
def bridge() -> ServiceTaskBridge:
    """A bridge with no real service providers (handles() doesn't need them)."""
    return ServiceTaskBridge({})


class TestServiceTaskBridgeHandles:
    """ServiceTaskBridge.handles() correctly classifies resource ARNs."""

    def test_handles_dynamodb_put_item(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::dynamodb:putItem"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_dynamodb_get_item(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::dynamodb:getItem"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_sqs_send_message(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::sqs:sendMessage"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_sns_publish(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::sns:publish"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_s3_get_object(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::s3:getObject"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_s3_put_object(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::s3:putObject"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_secretsmanager_get_secret_value(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::secretsmanager:getSecretValue"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_ssm_get_parameter(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::ssm:getParameter"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_handles_events_put_events(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = True
        resource_arn = "arn:aws:states:::events:putEvents"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_does_not_handle_lambda_invoke(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = False
        resource_arn = "arn:aws:states:::lambda:invoke"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_does_not_handle_plain_function_arn(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = False
        resource_arn = "arn:aws:lambda:us-east-1:000000000000:function:my-func"

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result

    def test_does_not_handle_empty_string(self, bridge: ServiceTaskBridge) -> None:
        # Arrange
        expected_result = False
        resource_arn = ""

        # Act
        actual_result = bridge.handles(resource_arn)

        # Assert
        assert actual_result == expected_result
