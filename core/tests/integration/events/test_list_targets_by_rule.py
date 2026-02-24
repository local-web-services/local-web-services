"""Integration test for EventBridge ListTargetsByRule."""

from __future__ import annotations

import json

import httpx


class TestListTargetsByRule:
    async def test_list_targets_by_rule(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "list-targets-rule"

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
            headers={"x-amz-target": "AWSEvents.ListTargetsByRule"},
            json={"Rule": expected_rule_name, "EventBusName": "default"},
        )

        # Assert
        assert resp.status_code == expected_status_code
