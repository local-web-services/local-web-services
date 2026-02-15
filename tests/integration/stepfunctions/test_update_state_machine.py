"""Integration test for Step Functions UpdateStateMachine."""

from __future__ import annotations

import json

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestUpdateStateMachine:
    async def test_update_state_machine(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        updated_definition = json.dumps(
            {"StartAt": "PassUpdated", "States": {"PassUpdated": {"Type": "Pass", "End": True}}}
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.UpdateStateMachine"},
            json={
                "stateMachineArn": _SM_ARN,
                "definition": updated_definition,
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
