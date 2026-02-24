"""Integration test for EventBridge RemoveTargets."""

from __future__ import annotations

import json

import httpx


class TestRemoveTargets:
    async def test_remove_targets(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "rm-targets-rule"

        await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutRule"},
            json={
                "Name": expected_rule_name,
                "EventBusName": "default",
                "EventPattern": json.dumps({"source": ["my.app"]}),
            },
        )
        await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.PutTargets"},
            json={
                "Rule": expected_rule_name,
                "Targets": [
                    {"Id": "t1", "Arn": "arn:aws:lambda:us-east-1:000000000000:function:fn"}
                ],
                "EventBusName": "default",
            },
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSEvents.RemoveTargets"},
            json={
                "Rule": expected_rule_name,
                "Ids": ["t1"],
                "EventBusName": "default",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
