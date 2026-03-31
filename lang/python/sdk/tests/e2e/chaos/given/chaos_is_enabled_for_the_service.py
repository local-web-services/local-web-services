"""Given: chaos was "ENABLED" for the service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SERVICE


@given('chaos was "ENABLED" for the service')
def chaos_is_enabled_for_the_service(lws_session):
    """Enable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).apply()
