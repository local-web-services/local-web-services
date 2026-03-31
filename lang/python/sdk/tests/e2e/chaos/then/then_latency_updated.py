"""Then: the latency configuration will be updated"""

from __future__ import annotations

from pytest_bdd import then


@then("the latency configuration will be updated")
def then_latency_updated(world):
    """Verify that the latency configuration call succeeded."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error
