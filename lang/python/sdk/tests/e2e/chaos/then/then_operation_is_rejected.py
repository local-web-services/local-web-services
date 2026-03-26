"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def then_operation_is_rejected(world):
    """Verify that the operation was rejected (an error was raised)."""
    expected_has_error = True
    actual_has_error = world.get("error") is not None
    assert actual_has_error == expected_has_error
