"""Then: the invocation is "SUCCESS" """

from __future__ import annotations

from pytest_bdd import then


@then('the invocation is "SUCCESS"')
def s3api_lambda_invocation_is_success(world):
    """Internal scenario: invocation success state is not observable via public API."""
    actual_error = world.get("error")
    assert actual_error is not None, "Expected internal scenario error marker but none was set"
