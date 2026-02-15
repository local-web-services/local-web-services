"""Integration test for SNS UntagResource."""

from __future__ import annotations

import httpx


class TestUntagResource:
    async def test_untag_resource(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_resource_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "UntagResource",
                "ResourceArn": expected_resource_arn,
                "TagKeys.member.1": "env",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
