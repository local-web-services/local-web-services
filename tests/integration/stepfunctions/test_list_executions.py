"""Integration test for Step Functions ListExecutions."""

from __future__ import annotations

import json

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestListExecutions:
    async def test_list_executions(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
            json={
                "stateMachineArn": _SM_ARN,
                "input": json.dumps({"key": "value"}),
            },
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.ListExecutions"},
            json={"stateMachineArn": _SM_ARN},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_executions = body["executions"]
        assert len(actual_executions) >= 1
        assert "executionArn" in actual_executions[0]
        assert "status" in actual_executions[0]
