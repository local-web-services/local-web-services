"""Then: the "s3" "object" metadata will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3" "object" metadata will be returned')
def object_metadata_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "ContentLength" in actual_result
    ), f"Expected object metadata in result but got: {actual_result}"
