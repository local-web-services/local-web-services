"""When: chaos was "ENABLED" for a service"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVICE


@when('chaos was "ENABLED" for a service')
def when_chaos_is_enabled(lws_session, world):
    """Enable chaos for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).apply()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
