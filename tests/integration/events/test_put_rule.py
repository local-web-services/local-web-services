"""Integration test for EventBridge PutRule."""

from __future__ import annotations

import json

import httpx


class TestPutRule:
    async def test_put_rule(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "test-rule"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutRule"},
            json={
                "Name": expected_rule_name,
                "EventBusName": "default",
                "EventPattern": json.dumps({"source": ["my.app"]}),
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert "RuleArn" in body
