"""When: LookupEvents is called with AttributeKey EventSource and AttributeValue sqs.amazonaws.com"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called with AttributeKey EventSource and AttributeValue sqs.amazonaws.com")
def lookup_events_is_called_with_event_source_sqs(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events(
            LookupAttributes=[
                {"AttributeKey": "EventSource", "AttributeValue": "sqs.amazonaws.com"}
            ]
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
