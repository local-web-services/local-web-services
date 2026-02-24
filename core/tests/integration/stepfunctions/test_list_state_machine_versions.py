"""Integration test for Step Functions ListStateMachineVersions."""

from __future__ import annotations

import httpx

_SM_ARN = "arn:aws:states:us-east-1:000000000000:stateMachine:PassMachine"


class TestListStateMachineVersions:
    async def test_list_state_machine_versions(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.ListStateMachineVersions"},
            json={"stateMachineArn": _SM_ARN},
        )

        # Assert
        assert resp.status_code == expected_status_code
