"""Integration test for EventBridge UntagResource."""

from __future__ import annotations

import httpx


class TestUntagResource:
    async def test_untag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_resource_arn = "arn:aws:events:us-east-1:123456789012:event-bus/default"

        await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.TagResource"},
            json={
                "ResourceARN": expected_resource_arn,
                "Tags": [{"Key": "env", "Value": "test"}],
            },
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.UntagResource"},
            json={
                "ResourceARN": expected_resource_arn,
                "TagKeys": ["env"],
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
