"""Given: the integration "EXISTS" """

from __future__ import annotations

from pytest_bdd import given


@given('the integration "EXISTS"')
def integration_exists(lws_session):
    """No-op: integration existence is verified after setup in the test."""
