"""Integration test for SNS Publish."""

from __future__ import annotations

import httpx


class TestPublish:
    async def test_publish_message(self, client: httpx.AsyncClient):
        # Arrange
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "Publish",
                "TopicArn": expected_topic_arn,
                "Message": "hello",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert "<MessageId>" in resp.text
