"""Integration test for Step Functions StartExecution."""

from __future__ import annotations

import json

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestStartExecution:
    async def test_start_execution(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
            json={
                "stateMachineArn": _SM_ARN,
                "input": json.dumps({"key": "value"}),
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert "executionArn" in body
