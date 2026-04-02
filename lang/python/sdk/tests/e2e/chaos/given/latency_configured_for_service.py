"""Given: "chaos" "latency" is configured for the "service" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_LATENCY_MAX_MS, TEST_LATENCY_MIN_MS, TEST_SERVICE


@given('"chaos" "latency" is configured for the "service"')
def latency_configured_for_service(lws_session):
    """Configure chaos with latency injection for the test service."""
    lws_session.chaos(TEST_SERVICE).latency(
        min_ms=TEST_LATENCY_MIN_MS, max_ms=TEST_LATENCY_MAX_MS
    ).apply()
