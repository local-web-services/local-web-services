"""Given: the "api gateway" "method" does not have an "api gateway" "integration" """

from __future__ import annotations

from pytest_bdd import given


@given('the "api gateway" "method" does not have an "api gateway" "integration"')
def method_does_not_have_integration():
    """No-op: fresh state has no integrations."""
