"""Given: chaos will be enabled for the service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SERVICE


@given("chaos will be enabled for the service")
def chaos_is_enabled(lws_session):
    """Enable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).apply()
