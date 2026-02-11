"""Integration test for Step Functions DescribeExecution."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestDescribeExecution:
    async def test_describe_execution(self, client: httpx.AsyncClient):
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
            headers={"x-amz-target": "AWSStepFunctions.DescribeExecution"},
            json={"executionArn": expected_execution_arn},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_execution_arn = body["executionArn"]
        assert actual_execution_arn == expected_execution_arn
        assert "status" in body
