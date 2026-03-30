"""Given: the method has an integration"""

from __future__ import annotations

from pytest_bdd import given


@given("the method has an integration")
def method_has_integration(lws_session):
    """No-op: integration existence is verified after setup in the test."""
