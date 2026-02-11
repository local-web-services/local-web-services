"""Integration test for Step Functions CreateStateMachine."""

from __future__ import annotations

import json

import httpx


class TestCreateStateMachine:
    async def test_create_state_machine(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_machine_name = "NewMachine"
        expected_definition = json.dumps(
            {"StartAt": "Init", "States": {"Init": {"Type": "Pass", "End": True}}}
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.CreateStateMachine"},
            json={
                "name": expected_machine_name,
                "definition": expected_definition,
                "roleArn": "arn:aws:iam::000000000000:role/test-role",
            },
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        assert "stateMachineArn" in body
        assert expected_machine_name in body["stateMachineArn"]
        assert "creationDate" in body
