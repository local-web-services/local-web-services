"""When: the chaos latency is configured for a service"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_LATENCY_MAX_MS, TEST_LATENCY_MIN_MS, TEST_SERVICE


@when("the chaos latency is configured for a service")
def when_chaos_latency_configured(lws_session, world):
    """Configure chaos latency for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).latency(
            min_ms=TEST_LATENCY_MIN_MS, max_ms=TEST_LATENCY_MAX_MS
        ).apply()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
