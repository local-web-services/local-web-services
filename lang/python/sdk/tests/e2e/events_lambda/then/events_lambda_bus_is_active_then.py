"""Then: the "eventbridge" "bus" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUS


@then('the "eventbridge" "bus" will be "ACTIVE"')
def events_lambda_bus_is_active_then(lws_session):
    resp = lws_session.client("events").describe_event_bus(Name=TEST_BUS)
    expected_name = TEST_BUS
    actual_name = resp.get("Name", "")
    assert (
        actual_name == expected_name
    ), f"Expected event bus '{expected_name}' to be ACTIVE but got '{actual_name}'"
