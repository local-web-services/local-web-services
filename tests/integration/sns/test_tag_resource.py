"""Integration test for SNS TagResource."""

from __future__ import annotations

import httpx


class TestTagResource:
    async def test_tag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_resource_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "TagResource",
                "ResourceArn": expected_resource_arn,
                "Tags.member.1.Key": "env",
                "Tags.member.1.Value": "test",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
