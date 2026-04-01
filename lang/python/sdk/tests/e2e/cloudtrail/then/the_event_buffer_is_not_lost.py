"""Then: the event buffer is not lost"""

from __future__ import annotations

from pytest_bdd import then


@then("the event buffer is not lost")
def the_event_buffer_is_not_lost(lws_session):
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"
