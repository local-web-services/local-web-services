"""Then: the available "s3" "buckets" will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the available "s3" "buckets" will be returned')
def available_buckets_returned_then(world):
    expected_field = "Buckets"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Buckets in result but got: {actual_result}"
