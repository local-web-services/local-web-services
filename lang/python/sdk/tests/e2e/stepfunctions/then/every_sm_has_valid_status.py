"""Then: every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsTestClient


@then('every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")')
def every_sm_has_valid_status(lws_session):
    list_resp = StepfunctionsTestClient(lws_session).list_state_machines()
    expected_statuses = {"ACTIVE", "DELETING", "DELETED"}
    for sm in list_resp.get("stateMachines", []):
        sm_arn = sm.get("stateMachineArn", "")
        describe_resp = StepfunctionsTestClient(lws_session).describe_state_machine(
            stateMachineArn=sm_arn
        )
        actual_status = describe_resp.get("status", "")
        assert (
            actual_status in expected_statuses
        ), f"State machine '{sm.get('name')}' has invalid status '{actual_status}'; expected one of {expected_statuses}"  # noqa: E501
