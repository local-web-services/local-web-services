"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def the_operation_is_rejected(world):
    actual_error = world.get("error")
    assert actual_error is not None, "Expected the operation to be rejected but no error was raised"
