"""Integration test for EventBridge DeleteRule."""

from __future__ import annotations

import json

import httpx


class TestDeleteRule:
    async def test_delete_rule(self, client: httpx.AsyncClient):
        # Arrange
        expected_rule_name = "rule-to-delete"
        expected_create_status = 200
        expected_delete_status = 200

        create_resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutRule"},
            json={
                "Name": expected_rule_name,
                "EventBusName": "default",
                "EventPattern": json.dumps({"source": ["my.app"]}),
            },
        )
        assert create_resp.status_code == expected_create_status

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.DeleteRule"},
            json={"Name": expected_rule_name},
        )

        # Assert
        assert resp.status_code == expected_delete_status
        body = resp.json()
        assert body == {}
