"""Then: the object is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the object is returned")
def object_is_returned_then(world):
    actual_result = world["result"]
    assert (
        actual_result is not None and "Body" in actual_result
    ), f"Expected object body in result but got: {actual_result}"
