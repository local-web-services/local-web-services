"""Integration test for EventBridge ListTagsForResource."""

from __future__ import annotations

import httpx


class TestListTagsForResource:
    async def test_list_tags_for_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_resource_arn = "arn:aws:events:us-east-1:123456789012:event-bus/default"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.ListTagsForResource"},
            json={"ResourceARN": expected_resource_arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
