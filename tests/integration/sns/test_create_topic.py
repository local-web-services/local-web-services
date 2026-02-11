"""Integration test for SNS CreateTopic."""

from __future__ import annotations

import httpx


class TestCreateTopic:
    async def test_create_topic(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_name = "new-integration-topic"
        expected_topic_arn_fragment = f":{expected_topic_name}"

        # Act
        resp = await client.post(
            "/",
            data={
                "Action": "CreateTopic",
                "Name": expected_topic_name,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert "<TopicArn>" in resp.text
        assert expected_topic_arn_fragment in resp.text
