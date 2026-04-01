"""Tests for build_cloudtrail_event: management events and error propagation."""

from __future__ import annotations

from lws.providers.cloudtrail._event_builder import build_cloudtrail_event


class TestCloudTrailEventBuilderManagementEvent:
    """Management event envelope: required fields and error codes."""

    def test_event_has_required_fields(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="CreateQueue",
            source_ip="127.0.0.1",
            username="developer",
            status_code=200,
        )

        # Assert
        expected_fields = [
            "eventVersion",
            "userIdentity",
            "eventTime",
            "eventSource",
            "eventName",
            "awsRegion",
            "sourceIPAddress",
            "eventType",
            "eventID",
            "readOnly",
            "recipientAccountId",
        ]
        for field in expected_fields:
            assert field in actual, f"Missing field: {field}"

    def test_event_name_matches_operation(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="CreateQueue",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
        )

        # Assert
        expected_event_name = "CreateQueue"
        assert actual["eventName"] == expected_event_name

    def test_event_source_matches_service(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="CreateQueue",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
        )

        # Assert
        expected_source = "sqs.amazonaws.com"
        assert actual["eventSource"] == expected_source

    def test_error_code_propagated(self) -> None:
        # Arrange
        expected_code = "ResourceNotFoundException"
        expected_message = "Queue not found"

        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="GetQueueUrl",
            source_ip="127.0.0.1",
            username="dev",
            status_code=400,
            error_code=expected_code,
            error_message=expected_message,
        )

        # Assert
        assert actual["errorCode"] == expected_code
        assert actual["errorMessage"] == expected_message

    def test_no_error_code_for_success(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="CreateQueue",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
        )

        # Assert
        assert "errorCode" not in actual
        assert "errorMessage" not in actual

    def test_user_identity_contains_username(self) -> None:
        # Arrange
        expected_username = "my-user"

        # Act
        actual = build_cloudtrail_event(
            service="dynamodb",
            operation="CreateTable",
            source_ip="10.0.0.1",
            username=expected_username,
            status_code=200,
        )

        # Assert
        assert actual["userIdentity"]["userName"] == expected_username

    def test_read_only_true_for_get_operations(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="GetQueueAttributes",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
        )

        # Assert
        assert actual["readOnly"] is True

    def test_read_only_false_for_write_operations(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="CreateQueue",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
        )

        # Assert
        assert actual["readOnly"] is False
