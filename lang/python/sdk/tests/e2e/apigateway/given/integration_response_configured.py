"""Given: a 200 integration response has been configured"""

from __future__ import annotations

from pytest_bdd import given


@given("a 200 integration response has been configured")
def integration_response_configured():
    """No-op: integration response is part of API setup in the test."""
