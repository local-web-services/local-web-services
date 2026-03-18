"""Integration test for SNS ConfirmSubscription."""

from __future__ import annotations

import httpx


class TestConfirmSubscription:
    async def test_confirm_subscription(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "ConfirmSubscription",
                "TopicArn": expected_topic_arn,
                "Token": "dummy-token",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
