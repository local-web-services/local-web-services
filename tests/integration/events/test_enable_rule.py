"""Integration test for EventBridge EnableRule."""

from __future__ import annotations

import json

import httpx


class TestEnableRule:
    async def test_enable_rule(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "enable-rule"

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
            headers={"x-amz-target": "AWSEvents.EnableRule"},
            json={"Name": expected_rule_name, "EventBusName": "default"},
        )

        # Assert
        assert resp.status_code == expected_status_code
