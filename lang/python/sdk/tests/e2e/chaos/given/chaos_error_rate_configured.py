"""Given: the chaos error rate has been configured for a service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SERVICE


@given("the chaos error rate has been configured for a service")
def chaos_error_rate_configured(lws_session):
    """Configure a non-zero error rate for the test service."""
    lws_session.chaos(TEST_SERVICE).error_rate(0.5).apply()
