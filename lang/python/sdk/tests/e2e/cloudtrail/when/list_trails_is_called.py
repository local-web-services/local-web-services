"""When: ListTrails is called"""

from __future__ import annotations

from pytest_bdd import when


@when("ListTrails is called")
def list_trails_is_called(lws_session, world):
    try:
        world["result"] = lws_session.client("cloudtrail").list_trails()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
