"""Tests for lws.providers.cloudtrail.routes -- CreateTrail operation."""

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


class TestCreateTrail:
    def test_create_trail_returns_trail_arn(self, client: TestClient) -> None:
        # Arrange
        body = {"Name": "test-trail-1", "S3BucketName": "my-bucket"}

        # Act
        result = _post(client, "CreateTrail", body)

        # Assert
        actual_arn = result.get("TrailARN")
        assert actual_arn is not None, f"Expected TrailARN to be set but got: {actual_arn}"

    def test_create_trail_returns_name(self, client: TestClient) -> None:
        # Arrange
        body = {"Name": "test-trail-1", "S3BucketName": "my-bucket"}

        # Act
        result = _post(client, "CreateTrail", body)

        # Assert
        actual_name = result.get("Name")
        expected_name = "test-trail-1"
        assert (
            actual_name == expected_name
        ), f"Expected trail name '{expected_name}' but got '{actual_name}'"

    def test_create_trail_duplicate_returns_error(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})

        # Act
        result = _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})

        # Assert
        actual_error_type = result.get("__type")
        assert (
            actual_error_type is not None
        ), "Expected an error when creating a duplicate trail but got none"

    def test_describe_trails_after_create_returns_trail(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})

        # Act
        result = _post(client, "DescribeTrails", {})

        # Assert
        actual_trails = result.get("trailList", [])
        actual_trail_names = [t["Name"] for t in actual_trails]
        expected_name = "test-trail-1"
        assert (
            expected_name in actual_trail_names
        ), f"Expected trail '{expected_name}' in trail list but found: {actual_trail_names}"
