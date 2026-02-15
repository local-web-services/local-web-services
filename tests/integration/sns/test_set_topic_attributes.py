"""Integration test for SNS SetTopicAttributes."""

from __future__ import annotations

import httpx


class TestSetTopicAttributes:
    async def test_set_topic_attributes(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "SetTopicAttributes",
                "TopicArn": expected_topic_arn,
                "AttributeName": "DisplayName",
                "AttributeValue": "Integration Test Topic",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
