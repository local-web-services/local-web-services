"""Then: all buckets are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("all buckets are returned")
def all_buckets_returned_then(world):
    expected_field = "Buckets"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected Buckets in result but got: {actual_result}"
