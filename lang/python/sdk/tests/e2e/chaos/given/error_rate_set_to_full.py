"""Given: the error rate is set to full for the service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_ERROR_RATE_FULL, TEST_SERVICE


@given("the error rate is set to full for the service")
def error_rate_set_to_full(lws_session):
    """Configure chaos with error rate of 1.0 (100%) for the test service."""
    lws_session.chaos(TEST_SERVICE).error_rate(TEST_ERROR_RATE_FULL).apply()
