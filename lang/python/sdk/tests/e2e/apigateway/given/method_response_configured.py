"""Given: a 200 method response has been configured"""

from __future__ import annotations

from pytest_bdd import given


@given("a 200 method response has been configured")
def method_response_configured():
    """No-op: method response is part of API setup in the test."""
