"""Test client for stepfunctions tests."""

from __future__ import annotations

from .constants import (
    _SFN_TARGET,
    INT_INPUT,
    INT_SM,
    PASS_DEFINITION,
    ROLE_ARN,
    _sm_arn,
)


class StepfunctionsTestClient:
    def __init__(self, client):
        self._client = client

    def create_sm(self, name: str = INT_SM, sm_type: str = "STANDARD") -> str:
        r = self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SFN_TARGET}.CreateStateMachine"},
            json={
                "name": name,
                "definition": PASS_DEFINITION,
                "roleArn": ROLE_ARN,
                "type": sm_type,
            },
        )
        return r.json().get("stateMachineArn", _sm_arn(name))

    def start_execution(self, sm_name: str = INT_SM) -> str:
        r = self._client.post(
            "/",
            headers={"X-Amz-Target": f"{_SFN_TARGET}.StartExecution"},
            json={"stateMachineArn": _sm_arn(sm_name), "input": INT_INPUT},
        )
        return r.json().get("executionArn", "")
