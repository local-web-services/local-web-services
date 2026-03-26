"""Given: chaos has been enabled for a service"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SERVICE


@given("chaos has been enabled for a service")
def chaos_has_been_enabled(lws_session):
    """Enable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).apply()
