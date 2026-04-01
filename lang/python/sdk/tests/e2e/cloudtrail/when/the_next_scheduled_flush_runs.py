"""When: the next scheduled flush runs"""

from __future__ import annotations

import requests
from pytest_bdd import when


@when("the next scheduled flush runs")
def the_next_scheduled_flush_runs(lws_session, world):
    try:
        base_url = lws_session.management_url.rstrip("/")
        resp = requests.post(f"{base_url}/_ldk/cloudtrail/flush", timeout=5)
        world["flush_result"] = resp
        world["error"] = None
    except Exception as exc:
        world["flush_result"] = None
        world["error"] = exc
