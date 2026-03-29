"""Tests for lws.providers.cloudtrail.routes -- logging state operations."""

from __future__ import annotations

import json

import pytest
from fastapi.testclient import TestClient

from lws.providers.cloudtrail.routes import create_cloudtrail_app

_TARGET = "CloudTrail_20131101"


@pytest.fixture()
def client() -> TestClient:
    app, _ = create_cloudtrail_app()
    return TestClient(app, raise_server_exceptions=False)


def _post(client: TestClient, action: str, body: dict) -> dict:
    resp = client.post(
        "/",
        headers={
            "Content-Type": "application/x-amz-json-1.1",
            "X-Amz-Target": f"{_TARGET}.{action}",
        },
        content=json.dumps(body),
    )
    return resp.json()


class TestLoggingState:
    def test_new_trail_has_logging_disabled(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})

        # Act
        result = _post(client, "GetTrailStatus", {"Name": "test-trail-1"})

        # Assert
        actual_logging = result.get("IsLogging")
        expected_logging = False
        assert (
            actual_logging == expected_logging
        ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"

    def test_start_logging_enables_logging(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})
        _post(client, "StartLogging", {"Name": "test-trail-1"})

        # Act
        result = _post(client, "GetTrailStatus", {"Name": "test-trail-1"})

        # Assert
        actual_logging = result.get("IsLogging")
        expected_logging = True
        assert (
            actual_logging == expected_logging
        ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"

    def test_stop_logging_disables_logging(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})
        _post(client, "StartLogging", {"Name": "test-trail-1"})
        _post(client, "StopLogging", {"Name": "test-trail-1"})

        # Act
        result = _post(client, "GetTrailStatus", {"Name": "test-trail-1"})

        # Assert
        actual_logging = result.get("IsLogging")
        expected_logging = False
        assert (
            actual_logging == expected_logging
        ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"

    def test_start_logging_unknown_trail_returns_error(self, client: TestClient) -> None:
        # Arrange
        body = {"Name": "nonexistent-trail"}

        # Act
        result = _post(client, "StartLogging", body)

        # Assert
        actual_error_type = result.get("__type")
        assert actual_error_type is not None, "Expected an error for unknown trail but got none"
