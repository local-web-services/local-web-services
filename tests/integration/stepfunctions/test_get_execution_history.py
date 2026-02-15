"""Integration test for Step Functions GetExecutionHistory."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestGetExecutionHistory:
    async def test_get_execution_history(self, client: httpx.AsyncClient):
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
            headers={"x-amz-target": "AWSStepFunctions.GetExecutionHistory"},
            json={"executionArn": expected_execution_arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
