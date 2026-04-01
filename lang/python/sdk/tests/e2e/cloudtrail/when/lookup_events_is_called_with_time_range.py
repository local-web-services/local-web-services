"""When: LookupEvents is called with StartTime and EndTime bounding a 10-minute window"""

from __future__ import annotations

import datetime

from pytest_bdd import when


@when("LookupEvents is called with StartTime and EndTime bounding a 10-minute window")
def lookup_events_is_called_with_time_range(lws_session, world):
    now = datetime.datetime.now(tz=datetime.UTC)
    start_time = now - datetime.timedelta(minutes=5)
    end_time = now + datetime.timedelta(minutes=5)
    try:
        world["result"] = lws_session.client("cloudtrail").lookup_events(
            StartTime=start_time,
            EndTime=end_time,
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
