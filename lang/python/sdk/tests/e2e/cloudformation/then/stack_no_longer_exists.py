"""Then: the "cloudformation" "stack" will no longer exist"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_STACK_NAME


@then('the "cloudformation" "stack" will no longer exist')
def stack_no_longer_exists(lws_session, world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected stack delete to succeed but got: {actual_error}"
    try:
        lws_session.client("cloudformation").describe_stacks(StackName=TEST_STACK_NAME)
        assert False, f"Expected stack {TEST_STACK_NAME!r} to no longer exist"
    except Exception:
        pass
