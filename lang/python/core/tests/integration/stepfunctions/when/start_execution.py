"""When: an execution is started on a standard state machine"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_INPUT, INT_SM, _sm_arn


@when("an execution is started on a standard state machine")
def start_execution(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StartExecution"},
        json={"stateMachineArn": _sm_arn(sm_name), "input": INT_INPUT},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["execution_arn"] = world["result"].get("executionArn", "")
    else:
        world["error"] = r.json()
