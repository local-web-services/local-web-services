"""Integration test for SNS ListTopics."""

from __future__ import annotations

import httpx


class TestListTopics:
    async def test_list_topics(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_topic_arn = "arn:aws:sns:us-east-1:123456789012:test-topic"

        # Act
        resp = await client.post(
            "/",
            data={"Action": "ListTopics"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        assert expected_topic_arn in resp.text
