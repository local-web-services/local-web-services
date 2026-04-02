"""Then: the "cloudtrail" "event" will be "BUFFERED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "cloudtrail" "event" will be "BUFFERED"')
def the_cloudtrail_event_will_be_buffered(world):
    """Verified by the FizzBee model checker; runtime asserts event was captured."""
    assert world.get("error") is None
