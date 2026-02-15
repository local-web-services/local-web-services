"""Integration test for EventBridge DisableRule."""

from __future__ import annotations

import json

import httpx


class TestDisableRule:
    async def test_disable_rule(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "disable-rule"

        await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutRule"},
            json={
                "Name": expected_rule_name,
                "EventBusName": "default",
                "EventPattern": json.dumps({"source": ["my.app"]}),
            },
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.DisableRule"},
            json={"Name": expected_rule_name, "EventBusName": "default"},
        )

        # Assert
        assert resp.status_code == expected_status_code
