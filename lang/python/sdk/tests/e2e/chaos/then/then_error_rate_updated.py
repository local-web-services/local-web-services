"""Then: the error rate configuration is updated"""

from __future__ import annotations

from pytest_bdd import then


@then("the error rate configuration is updated")
def then_error_rate_updated(world):
    """Verify that the error rate configuration call succeeded."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error
