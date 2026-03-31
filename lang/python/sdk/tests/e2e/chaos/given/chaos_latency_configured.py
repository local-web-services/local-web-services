"""Given: the chaos latency is configured for a service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_LATENCY_MAX_MS, TEST_LATENCY_MIN_MS, TEST_SERVICE


@given("the chaos latency is configured for a service")
def chaos_latency_configured(lws_session):
    """Configure latency injection for the test service."""
    lws_session.chaos(TEST_SERVICE).latency(
        min_ms=TEST_LATENCY_MIN_MS, max_ms=TEST_LATENCY_MAX_MS
    ).apply()
