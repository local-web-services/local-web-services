"""Integration test for SNS Subscribe."""

from __future__ import annotations

import httpx


class TestSubscribe:
    async def test_subscribe(self, client: httpx.AsyncClient):
        # Arrange
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"
        expected_endpoint = "arn:aws:sqs:us-east-1:123456789012:my-queue"
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "Subscribe",
                "TopicArn": expected_topic_arn,
                "Protocol": "sqs",
                "Endpoint": expected_endpoint,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert "<SubscriptionArn>" in resp.text
