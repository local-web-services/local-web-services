"""Then: the object metadata is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the object metadata is returned")
def object_metadata_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "ContentLength" in actual_result
    ), f"Expected object metadata in result but got: {actual_result}"
