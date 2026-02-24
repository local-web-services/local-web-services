"""Integration test for SNS ListSubscriptionsByTopic."""

from __future__ import annotations

import httpx


class TestListSubscriptionsByTopic:
    async def test_list_subscriptions_by_topic(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ListSubscriptionsByTopic",
                "TopicArn": expected_topic_arn,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
