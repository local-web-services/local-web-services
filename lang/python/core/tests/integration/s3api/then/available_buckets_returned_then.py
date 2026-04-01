"""Then: the available "s3" "buckets" will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the available "s3" "buckets" will be returned')
def available_buckets_returned_then(world):
    actual_result = world["result"]
    expected_marker = "ListAllMyBucketsResult"
    assert (
        actual_result is not None and expected_marker in actual_result
    ), f"Expected '{expected_marker}' in result but got: {actual_result}"
