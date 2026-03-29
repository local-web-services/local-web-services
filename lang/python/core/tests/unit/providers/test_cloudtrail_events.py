"""Tests for lws.providers.cloudtrail.routes -- LookupEvents operation."""

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


class TestLookupEvents:
    def test_lookup_events_after_api_call_returns_events(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})

        # Act
        result = _post(client, "LookupEvents", {})

        # Assert
        actual_events = result.get("Events", [])
        assert len(actual_events) > 0, f"Expected at least one event but got: {actual_events}"

    def test_lookup_events_with_max_results_limits_response(self, client: TestClient) -> None:
        # Arrange
        for i in range(5):
            _post(client, "CreateTrail", {"Name": f"test-trail-{i}", "S3BucketName": "my-bucket"})

        # Act
        result = _post(client, "LookupEvents", {"MaxResults": 2})

        # Assert
        actual_events = result.get("Events", [])
        expected_max = 2
        actual_count = len(actual_events)
        assert (
            actual_count <= expected_max
        ), f"Expected at most {expected_max} events but got {actual_count}"
        actual_next_token = result.get("NextToken")
        assert (
            actual_next_token is not None
        ), "Expected NextToken when results are truncated but got None"

    def test_lookup_events_filter_by_event_name(self, client: TestClient) -> None:
        # Arrange
        _post(client, "CreateTrail", {"Name": "test-trail-1", "S3BucketName": "my-bucket"})
        _post(client, "StartLogging", {"Name": "test-trail-1"})

        # Act
        result = _post(
            client,
            "LookupEvents",
            {"LookupAttributes": [{"AttributeKey": "EventName", "AttributeValue": "CreateTrail"}]},
        )

        # Assert
        actual_events = result.get("Events", [])
        actual_event_names = {e.get("EventName") for e in actual_events}
        expected_event_name = "CreateTrail"
        assert all(
            name == expected_event_name for name in actual_event_names
        ), f"Expected only '{expected_event_name}' events but found: {actual_event_names}"
