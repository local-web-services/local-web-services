"""Integration test for Lambda CreateEventSourceMapping."""

from __future__ import annotations

import httpx


class TestCreateEventSourceMapping:
    async def test_create_event_source_mapping(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 202
        expected_function_name = "esm-function"
        expected_event_source_arn = "arn:aws:sqs:us-east-1:123456789012:test-queue"

        # Act
        resp = await client.post(
            "/2015-03-31/event-source-mappings",
            json={
                "FunctionName": expected_function_name,
                "EventSourceArn": expected_event_source_arn,
            },
        )

        # Assert
        actual_status_code = resp.status_code
        assert actual_status_code == expected_status_code
