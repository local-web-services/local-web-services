"""Then: the state machine is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import _SFN_TARGET, INT_SM, _sm_arn


@then('the state machine is "ACTIVE"')
def sm_is_active_then(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    expected_status = "ACTIVE"
    actual_status = r.json().get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"
