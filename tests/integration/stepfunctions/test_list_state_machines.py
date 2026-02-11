"""Integration test for Step Functions ListStateMachines."""

from __future__ import annotations

import httpx


class TestListStateMachines:
    async def test_list_state_machines(self, client: httpx.AsyncClient):
        # Arrange
        expected_status_code = 200
        expected_machine_name = "PassMachine"

        # Act
        resp = await client.post(
            "/",
            headers={"x-amz-target": "AWSStepFunctions.ListStateMachines"},
            json={},
        )

        # Assert
        assert resp.status_code == expected_status_code
        body = resp.json()
        actual_names = [sm["name"] for sm in body["stateMachines"]]
        assert expected_machine_name in actual_names
