"""Integration test for EventBridge TagResource."""

from __future__ import annotations

import httpx


class TestTagResource:
    async def test_tag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_resource_arn = "arn:aws:events:us-east-1:123456789012:event-bus/default"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.TagResource"},
            json={
                "ResourceARN": expected_resource_arn,
                "Tags": [{"Key": "env", "Value": "test"}],
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
