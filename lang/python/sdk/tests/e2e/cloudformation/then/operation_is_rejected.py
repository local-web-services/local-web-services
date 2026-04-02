"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def operation_is_rejected(world):
    expected_error = "an error"
    actual_error = world["error"]
    assert (
        actual_error is not None
    ), f"Expected {expected_error} but the operation succeeded with result: {world['result']}"
