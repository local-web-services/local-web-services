"""When: LookupEvents is called with AttributeKey Username and AttributeValue developer"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called with AttributeKey Username and AttributeValue developer")
def lookup_events_is_called_with_username_developer(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events(
            LookupAttributes=[{"AttributeKey": "Username", "AttributeValue": "developer"}]
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
