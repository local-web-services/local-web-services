"""Then: the "step functions" "state machine" will be deleted and Lambda StartExecution calls will fail"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..constants import TEST_SM, _sm_arn


@then(
    'the "step functions" "state machine" will be deleted and Lambda StartExecution calls will fail'
)
def sm_is_deleted_then(lws_session):
    try:
        lws_session.client("stepfunctions").describe_state_machine(stateMachineArn=_sm_arn())
        raise AssertionError(
            f"Expected state machine '{TEST_SM}' to be deleted but it still exists"
        )
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "StateMachineDoesNotExist"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"
