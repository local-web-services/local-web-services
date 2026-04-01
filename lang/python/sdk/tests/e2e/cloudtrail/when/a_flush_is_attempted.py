"""When: a flush is attempted"""

from __future__ import annotations

import requests
from pytest_bdd import when


@when("a flush is attempted")
def a_flush_is_attempted(lws_session, world):
    try:
        base_url = lws_session.management_url.rstrip("/")
        resp = requests.post(f"{base_url}/_ldk/cloudtrail/flush", timeout=5)
        world["flush_result"] = resp
        world["error"] = None
    except Exception as exc:
        world["flush_result"] = None
        world["error"] = exc
