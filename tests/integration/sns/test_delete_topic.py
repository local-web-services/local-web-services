"""Integration test for SNS DeleteTopic."""

from __future__ import annotations

import httpx


class TestDeleteTopic:
    async def test_delete_topic(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_name = "topic-to-delete"
        expected_topic_arn = f"arn:aws:sns:us-east-1:000000000000:{expected_topic_name}"

        await client.post(
            "/",
            data={
                "Action": "CreateTopic",
                "Name": expected_topic_name,
            },
        )

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "DeleteTopic",
                "TopicArn": expected_topic_arn,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
