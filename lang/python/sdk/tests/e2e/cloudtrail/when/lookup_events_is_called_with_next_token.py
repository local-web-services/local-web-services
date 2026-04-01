"""When: LookupEvents is called with that NextToken"""

from __future__ import annotations

from pytest_bdd import when


@when("LookupEvents is called with that NextToken")
def lookup_events_is_called_with_next_token(lws_session, world):
    next_token = world.get("next_token")
    try:
        kwargs = {"MaxResults": 50}
        if next_token:
            kwargs["NextToken"] = next_token
        world["result"] = lws_session.client("cloudtrail").lookup_events(**kwargs)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
