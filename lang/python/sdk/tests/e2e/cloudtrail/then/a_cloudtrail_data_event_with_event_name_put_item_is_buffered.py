"""Then: a cloudtrail data event with eventName PutItem is buffered"""

from __future__ import annotations

from pytest_bdd import then


@then("a cloudtrail data event with eventName PutItem is buffered")
def a_cloudtrail_data_event_with_event_name_put_item_is_buffered(lws_session, world):
    resp = lws_session.client("cloudtrail").lookup_events(
        LookupAttributes=[{"AttributeKey": "EventName", "AttributeValue": "PutItem"}]
    )
    actual_events = resp.get("Events", [])
    assert (
        len(actual_events) >= 1
    ), f"Expected at least 1 PutItem event buffered but got {len(actual_events)}"
    world["found_event"] = actual_events[0]
