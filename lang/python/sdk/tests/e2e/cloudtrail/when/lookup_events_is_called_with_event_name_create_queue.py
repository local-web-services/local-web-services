"""When: LookupEvents is called with AttributeKey EventName and AttributeValue CreateQueue"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called with AttributeKey EventName and AttributeValue CreateQueue")
def lookup_events_is_called_with_event_name_create_queue(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events(
            LookupAttributes=[{"AttributeKey": "EventName", "AttributeValue": "CreateQueue"}]
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
