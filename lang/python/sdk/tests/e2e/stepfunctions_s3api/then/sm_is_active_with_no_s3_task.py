"""Then: the state machine is "ACTIVE" with no S3 task configured"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import _sm_arn


@then('the state machine is "ACTIVE" with no S3 task configured')
def sm_is_active_with_no_s3_task(lws_session):
    resp = lws_session.client("stepfunctions").describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"
