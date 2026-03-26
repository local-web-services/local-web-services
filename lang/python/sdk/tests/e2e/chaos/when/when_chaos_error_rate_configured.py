"""When: the chaos error rate is configured for a service"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SERVICE


@when("the chaos error rate is configured for a service")
def when_chaos_error_rate_configured(lws_session, world):
    """Configure a chaos error rate for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).error_rate(0.5).apply()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
