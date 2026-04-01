"""When: a synchronous execution is started on an express "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_INPUT, INT_SM_EXPRESS, _sm_arn


@when('a synchronous execution is started on an express "step functions" "state machine"')
def start_sync_execution(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM_EXPRESS)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StartSyncExecution"},
        json={"stateMachineArn": _sm_arn(sm_name), "input": INT_INPUT},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
