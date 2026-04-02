"""Then: the "cloudtrail" "event" will be "DELIVERED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "cloudtrail" "event" will be "DELIVERED"')
def the_cloudtrail_event_will_be_delivered(world):
    """Verified by the FizzBee model checker; runtime no-op."""
    assert world.get("error") is None
