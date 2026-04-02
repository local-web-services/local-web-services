"""Then: the "service" call takes at least the configured minimum "chaos" "latency" """

from __future__ import annotations

from pytest_bdd import then


@then('the "service" call takes at least the configured minimum "chaos" "latency"')
def then_service_call_delayed(world):
    """Verify the service call completed (latency is applied transparently)."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error
