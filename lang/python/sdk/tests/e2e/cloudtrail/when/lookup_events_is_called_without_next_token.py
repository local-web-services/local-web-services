"""When: LookupEvents is called without a NextToken"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called without a NextToken")
def lookup_events_is_called_without_next_token(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events(MaxResults=50)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
