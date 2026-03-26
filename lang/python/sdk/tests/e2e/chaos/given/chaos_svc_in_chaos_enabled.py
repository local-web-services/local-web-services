"""Given: svc in chaos_enabled"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SERVICE


@given("svc in chaos_enabled")
def chaos_svc_in_chaos_enabled(lws_session):
    """Enable chaos for the test service to represent a service in the chaos_enabled set."""
    lws_session.chaos(TEST_SERVICE).apply()
