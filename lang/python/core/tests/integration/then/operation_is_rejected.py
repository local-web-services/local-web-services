"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def operation_is_rejected(world):
    actual_error = world["error"]
    assert actual_error is not None, (
        "Expected an error but the operation succeeded with result: " f"{world['result']}"
    )
