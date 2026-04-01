"""Then: the "cloudformation" "stack" will be "UPDATE_COMPLETE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_STACK_NAME


@then('the "cloudformation" "stack" will be "UPDATE_COMPLETE"')
def stack_is_update_complete(lws_session, world):
    expected_status = "UPDATE_COMPLETE"
    response = lws_session.client("cloudformation").describe_stacks(StackName=TEST_STACK_NAME)
    actual_status = response["Stacks"][0]["StackStatus"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}"
