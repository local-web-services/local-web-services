"""Integration test for SNS GetSubscriptionAttributes."""

from __future__ import annotations

import httpx


class TestGetSubscriptionAttributes:
    async def test_get_subscription_attributes(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"
        expected_endpoint = "arn:aws:sqs:us-east-1:123456789012:get-sub-attrs-queue"

        sub_resp = await client.post(
            "/",
            data={
                "Action": "Subscribe",
                "TopicArn": expected_topic_arn,
                "Protocol": "sqs",
                "Endpoint": expected_endpoint,
            },
        )
        assert "<SubscriptionArn>" in sub_resp.text

        text = sub_resp.text
        start = text.index("<SubscriptionArn>") + len("<SubscriptionArn>")
        end = text.index("</SubscriptionArn>")
        subscription_arn = text[start:end]

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "GetSubscriptionAttributes",
                "SubscriptionArn": subscription_arn,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
