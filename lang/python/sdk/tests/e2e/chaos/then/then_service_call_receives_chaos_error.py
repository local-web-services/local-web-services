"""Then: the service call receives a chaos error response"""

from __future__ import annotations

from pytest_bdd import then


@then("the service call receives a chaos error response")
def then_service_call_receives_chaos_error(world):
    """Verify that the service call was rejected due to chaos error injection."""
    expected_has_error = True
    actual_has_error = world.get("error") is not None
    assert actual_has_error == expected_has_error
