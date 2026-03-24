"""Unit tests for API Gateway V1 integration URI parsing."""

from __future__ import annotations

import pytest

from lws.providers.apigateway._apigateway_v1_dispatch import _parse_integration_uri


class TestParseIntegrationUri:
    def test_dynamodb_action_returns_service_and_action(self) -> None:
        # Arrange
        expected_service = "dynamodb"
        expected_action = "PutItem"
        uri = "arn:aws:apigateway:us-east-1:dynamodb:action/PutItem"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, f"Expected parsed result but got None for URI: {uri}"
        assert (
            actual_result["service"] == expected_service
        ), f"Expected service {expected_service!r} but got {actual_result['service']!r}"
        assert (
            actual_result["action"] == expected_action
        ), f"Expected action {expected_action!r} but got {actual_result['action']!r}"

    def test_sqs_path_returns_service_and_queue(self) -> None:
        # Arrange
        expected_service = "sqs"
        expected_queue = "my-queue"
        uri = "arn:aws:apigateway:us-east-1:sqs:path/000000000000/my-queue"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, f"Expected parsed result but got None for URI: {uri}"
        assert (
            actual_result["service"] == expected_service
        ), f"Expected service {expected_service!r} but got {actual_result['service']!r}"
        assert (
            actual_result["queue"] == expected_queue
        ), f"Expected queue {expected_queue!r} but got {actual_result['queue']!r}"

    def test_sns_action_returns_service_and_action(self) -> None:
        # Arrange
        expected_service = "sns"
        expected_action = "Publish"
        uri = "arn:aws:apigateway:us-east-1:sns:action/Publish"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, f"Expected parsed result but got None for URI: {uri}"
        assert (
            actual_result["service"] == expected_service
        ), f"Expected service {expected_service!r} but got {actual_result['service']!r}"
        assert (
            actual_result["action"] == expected_action
        ), f"Expected action {expected_action!r} but got {actual_result['action']!r}"

    def test_s3_path_returns_service_bucket_and_key(self) -> None:
        # Arrange
        expected_service = "s3"
        expected_bucket = "my-bucket"
        expected_key = "my-key"
        uri = "arn:aws:apigateway:us-east-1:s3:path/my-bucket/my-key"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, f"Expected parsed result but got None for URI: {uri}"
        assert (
            actual_result["service"] == expected_service
        ), f"Expected service {expected_service!r} but got {actual_result['service']!r}"
        assert (
            actual_result["bucket"] == expected_bucket
        ), f"Expected bucket {expected_bucket!r} but got {actual_result['bucket']!r}"
        assert (
            actual_result["key"] == expected_key
        ), f"Expected key {expected_key!r} but got {actual_result['key']!r}"

    def test_states_action_returns_service_and_action(self) -> None:
        # Arrange
        expected_service = "states"
        expected_action = "StartExecution"
        uri = "arn:aws:apigateway:us-east-1:states:action/StartExecution"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert actual_result is not None, f"Expected parsed result but got None for URI: {uri}"
        assert (
            actual_result["service"] == expected_service
        ), f"Expected service {expected_service!r} but got {actual_result['service']!r}"
        assert (
            actual_result["action"] == expected_action
        ), f"Expected action {expected_action!r} but got {actual_result['action']!r}"

    def test_unknown_uri_returns_none(self) -> None:
        # Arrange
        expected_result = None
        uri = "arn:aws:apigateway:us-east-1:lambda:path/functions/my-fn/invocations"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert (
            actual_result is expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r} for URI: {uri}"

    def test_empty_uri_returns_none(self) -> None:
        # Arrange
        expected_result = None
        uri = ""

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert (
            actual_result is expected_result
        ), f"Expected {expected_result!r} but got {actual_result!r}"

    @pytest.mark.parametrize(
        "region",
        ["us-east-1", "eu-west-1", "ap-southeast-2"],
    )
    def test_dynamodb_uri_with_different_regions(self, region: str) -> None:
        # Arrange
        expected_service = "dynamodb"
        expected_action = "GetItem"
        uri = f"arn:aws:apigateway:{region}:dynamodb:action/GetItem"

        # Act
        actual_result = _parse_integration_uri(uri)

        # Assert
        assert (
            actual_result is not None
        ), f"Expected parsed result but got None for region {region!r}"
        assert (
            actual_result["service"] == expected_service
        ), f"Expected service {expected_service!r} but got {actual_result['service']!r}"
        assert (
            actual_result["action"] == expected_action
        ), f"Expected action {expected_action!r} but got {actual_result['action']!r}"
