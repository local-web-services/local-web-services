"""Integration test for EventBridge ListRules."""

from __future__ import annotations

import json

import httpx


class TestListRules:
    async def test_list_rules(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "listed-rule"

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
            headers={"x-amz-target": "AWSEvents.ListRules"},
            json={"EventBusName": "default"},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_rule_names = [r["Name"] for r in body["Rules"]]
        assert expected_rule_name in actual_rule_names
