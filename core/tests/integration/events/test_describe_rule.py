"""Integration test for EventBridge DescribeRule."""

from __future__ import annotations

import json

import httpx


class TestDescribeRule:
    async def test_describe_rule(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_rule_name = "describe-rule"

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
            headers={"x-amz-target": "AWSEvents.DescribeRule"},
            json={"Name": expected_rule_name, "EventBusName": "default"},
        )

        # Assert
        assert resp.status_code == expected_status_code
