"""Given: chaos has been disabled for a service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SERVICE


@given("chaos has been disabled for a service")
def chaos_has_been_disabled(lws_session):
    """Disable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).clear()
