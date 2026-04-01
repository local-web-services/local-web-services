"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def operation_is_rejected_then(world):
    assert (
        world.get("error") is not None
    ), "Expected the operation to be rejected but no error was raised"
