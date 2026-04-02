"""When: all "eventbridge" "bus"es are listed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('all "eventbridge" "bus"es are listed')
def list_event_buses(lws_session, world):
    try:
        resp = lws_session.client("events").list_event_buses()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
