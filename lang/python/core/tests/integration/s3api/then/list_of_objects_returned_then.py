"""Then: the list of objects in the "s3" "bucket" will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the list of objects in the "s3" "bucket" will be returned')
def list_of_objects_returned_then(world):
    actual_result = world["result"]
    expected_marker = "ListBucketResult"
    assert (
        actual_result is not None and expected_marker in actual_result
    ), f"Expected '{expected_marker}' in result but got: {actual_result}"
