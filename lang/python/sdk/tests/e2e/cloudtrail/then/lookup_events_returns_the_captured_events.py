"""Then: LookupEvents returns the captured events"""

from __future__ import annotations

from pytest_bdd import then


@then("LookupEvents returns the captured events")
def lookup_events_returns_the_captured_events(lws_session):
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"
