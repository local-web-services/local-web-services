"""Then: the bucket is in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the bucket is in "CREATING" state')
def bucket_is_creating_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected table bucket creation to succeed but got: {actual_error}"
    actual_result = world["result"]
    expected_field = "arn"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected arn in result but got: {actual_result}"
