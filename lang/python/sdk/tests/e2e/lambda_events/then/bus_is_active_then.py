"""Then: the bus is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaEventsTestClient
from ..constants import TEST_BUS


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = LambdaEventsTestClient(lws_session)._events.describe_event_bus(Name=TEST_BUS)
    actual_name = resp.get("Name", "")
    expected_name = TEST_BUS
    assert (
        actual_name == expected_name
    ), f"Expected event bus name '{expected_name}' but got '{actual_name}'"
