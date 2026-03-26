"""Then: the state machine is "ACTIVE" with no S3 task configured"""

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsS3apiTestClient
from ..constants import _sm_arn


@then('the state machine is "ACTIVE" with no S3 task configured')
def sm_is_active_with_no_s3_task(lws_session):
    resp = StepfunctionsS3apiTestClient(lws_session)._sfn.describe_state_machine(
        stateMachineArn=_sm_arn()
    )
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"
