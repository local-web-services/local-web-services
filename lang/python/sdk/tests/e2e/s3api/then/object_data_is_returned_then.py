"""Then: the "s3" "object" data will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3" "object" data will be returned')
def object_data_is_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "Body" in actual_result
    ), f"Expected object body in result but got: {actual_result}"
