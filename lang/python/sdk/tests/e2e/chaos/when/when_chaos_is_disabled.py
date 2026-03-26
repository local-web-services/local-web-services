"""When: chaos is disabled for a service"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVICE


@when("chaos is disabled for a service")
def when_chaos_is_disabled(lws_session, world):
    """Disable chaos for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).clear()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
