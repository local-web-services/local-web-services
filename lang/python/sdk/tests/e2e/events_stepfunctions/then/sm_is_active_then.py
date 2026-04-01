"""Then: the "step functions" "state machine" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import _sm_arn


@then('the "step functions" "state machine" will be "ACTIVE"')
def sm_is_active_then(lws_session, world):
    sm_arn = world.get("state_machine_arn", _sm_arn())
    resp = lws_session.client("stepfunctions").describe_state_machine(stateMachineArn=sm_arn)
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"
