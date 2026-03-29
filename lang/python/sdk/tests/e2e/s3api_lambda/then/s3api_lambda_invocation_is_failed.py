"""Then: the invocation is "FAILED" """

from __future__ import annotations

from pytest_bdd import then


@then('the invocation is "FAILED"')
def s3api_lambda_invocation_is_failed(world):
    """Internal scenario: invocation failure state is not observable via public API."""
    actual_error = world.get("error")
    assert actual_error is not None, "Expected internal scenario error marker but none was set"
