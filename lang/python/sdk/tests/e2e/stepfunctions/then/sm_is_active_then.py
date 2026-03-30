"""Then: the state machine is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_SM, _sm_arn


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session, world):
    sm_name = world.get("state_machine_name") or TEST_SM
    resp = lws_session.client("stepfunctions").describe_state_machine(
        stateMachineArn=_sm_arn(sm_name)
    )
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"
