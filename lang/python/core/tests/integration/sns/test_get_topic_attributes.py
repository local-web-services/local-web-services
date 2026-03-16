"""Integration test for SNS GetTopicAttributes."""

from __future__ import annotations

import httpx


class TestGetTopicAttributes:
    async def test_get_topic_attributes(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "GetTopicAttributes",
                "TopicArn": expected_topic_arn,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
