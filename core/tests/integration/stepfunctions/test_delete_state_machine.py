"""Integration test for Step Functions DeleteStateMachine."""

from __future__ import annotations

import json

import httpx


class TestDeleteStateMachine:
    async def test_delete_state_machine(self, client: httpx.AsyncClient):
        # Arrange
        expected_create_status = 200
        expected_delete_status = 200
        expected_machine_name = "MachineToDelete"
        expected_definition = json.dumps(
            {"StartAt": "Init", "States": {"Init": {"Type": "Pass", "End": True}}}
        )

        create_resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.CreateStateMachine"},
            json={
                "name": expected_machine_name,
                "definition": expected_definition,
                "roleArn": "arn:aws:iam::000000000000:role/test-role",
            },
        )
        assert create_resp.status_code == expected_create_status
        created_arn = create_resp.json()["stateMachineArn"]

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.DeleteStateMachine"},
            json={"stateMachineArn": created_arn},
        )

        # Assert
        assert resp.status_code == expected_delete_status
        body = resp.json()
        assert body == {}
