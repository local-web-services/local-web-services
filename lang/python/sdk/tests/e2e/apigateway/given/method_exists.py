"""Given: the method "EXISTS" """

from __future__ import annotations

from pytest_bdd import given


@given('the method "EXISTS"')
def method_exists(lws_session):
    """No-op: method existence is verified after API creation in the test."""
