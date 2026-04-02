"""When: the "chaos" status for all "services" is retrieved"""

from __future__ import annotations

from pytest_bdd import when

from ..client import ChaosTestClient


@when('the "chaos" status for all "services" is retrieved')
def when_chaos_status_retrieved(lws_session, world):
    """Retrieve chaos status for all services and record the result."""
    try:
        world["result"] = ChaosTestClient(lws_session).get_chaos_status()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
