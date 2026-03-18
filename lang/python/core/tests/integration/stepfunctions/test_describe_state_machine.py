"""Integration test for Step Functions DescribeStateMachine."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestDescribeStateMachine:
    async def test_describe_state_machine(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_machine_name = "PassMachine"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.DescribeStateMachine"},
            json={"stateMachineArn": _SM_ARN},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert body["name"] == expected_machine_name
        assert "stateMachineArn" in body
