"""Integration test for SNS ListTagsForResource."""

from __future__ import annotations

import httpx


class TestListTagsForResource:
    async def test_list_tags_for_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_resource_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ListTagsForResource",
                "ResourceArn": expected_resource_arn,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
