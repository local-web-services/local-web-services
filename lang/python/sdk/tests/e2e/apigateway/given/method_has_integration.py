"""Given: the "api gateway" "method" has an "api gateway" "integration" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "method" has an "api gateway" "integration"')
def method_has_integration(lws_session):
    """No-op: integration existence is verified after setup in the test."""
