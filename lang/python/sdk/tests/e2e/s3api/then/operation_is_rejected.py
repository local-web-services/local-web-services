"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def operation_is_rejected(world):
    actual_error = world.get("error")
    assert (
        actual_error is not None
    ), f"Expected the operation to be rejected but it succeeded with: {world.get('result')}"
