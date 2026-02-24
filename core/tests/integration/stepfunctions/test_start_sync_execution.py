"""Integration test for Step Functions StartSyncExecution."""

from __future__ import annotations

import json

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestStartSyncExecution:
    async def test_start_sync_execution(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.StartSyncExecution"},
            json={
                "stateMachineArn": _SM_ARN,
                "input": json.dumps({}),
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
