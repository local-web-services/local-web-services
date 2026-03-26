"""Then: the state machine is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsSnsTestClient
from ..constants import _sm_arn


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = StepfunctionsSnsTestClient(lws_session)._sfn.describe_state_machine(
        stateMachineArn=_sm_arn()
    )
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"
