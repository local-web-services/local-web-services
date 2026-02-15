"""Integration test for Step Functions ValidateStateMachineDefinition."""

from __future__ import annotations

import json

import httpx


class TestValidateStateMachineDefinition:
    async def test_validate_state_machine_definition(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        definition = json.dumps(
            {"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}}
        )

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.ValidateStateMachineDefinition"},
            json={"definition": definition},
        )

        # Assert
        assert resp.status_code == expected_status_code
