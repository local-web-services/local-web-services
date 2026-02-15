"""Integration test for Step Functions StopExecution."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestStopExecution:
    async def test_stop_execution(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        start_resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StartExecution"},
            json={"stateMachineArn": _SM_ARN},
        )
        expected_execution_arn = start_resp.json()["executionArn"]

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StopExecution"},
            json={"executionArn": expected_execution_arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
