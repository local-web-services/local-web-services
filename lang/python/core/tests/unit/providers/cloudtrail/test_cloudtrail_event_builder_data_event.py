"""Tests for build_cloudtrail_event: data events with resource ARNs."""

from __future__ import annotations

from lws.providers.cloudtrail._event_builder import build_cloudtrail_event


class TestCloudTrailEventBuilderDataEvent:
    """Data event envelope: resource fields for S3 and DynamoDB."""

    def test_s3_putobject_carries_resource(self) -> None:
        # Arrange
        expected_arn = "arn:aws:s3:::my-bucket/my-key.txt"
        resources = [{"type": "AWS::S3::Object", "ARN": expected_arn}]

        # Act
        actual = build_cloudtrail_event(
            service="s3",
            operation="PutObject",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
            resources=resources,
        )

        # Assert
        assert "resources" in actual
        actual_arn = actual["resources"][0]["ARN"]
        assert actual_arn == expected_arn

    def test_dynamodb_putitem_carries_table_resource(self) -> None:
        # Arrange
        expected_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/MyTable"
        resources = [{"type": "AWS::DynamoDB::Table", "ARN": expected_arn}]

        # Act
        actual = build_cloudtrail_event(
            service="dynamodb",
            operation="PutItem",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
            resources=resources,
        )

        # Assert
        assert actual["resources"][0]["ARN"] == expected_arn
        expected_source = "dynamodb.amazonaws.com"
        assert actual["eventSource"] == expected_source

    def test_no_resources_key_when_none_provided(self) -> None:
        # Act
        actual = build_cloudtrail_event(
            service="sqs",
            operation="SendMessage",
            source_ip="127.0.0.1",
            username="dev",
            status_code=200,
        )

        # Assert
        assert "resources" not in actual
