"""Then: the queue attributes are returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the queue attributes are returned")
def queue_attributes_returned_then(world):
    expected_field = "Attributes"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected queue attributes in result but got: {actual_result}"
