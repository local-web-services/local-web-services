"""Given: the method does not have an integration"""

from __future__ import annotations

from pytest_bdd import given


@given("the method does not have an integration")
def method_does_not_have_integration():
    """No-op: fresh state has no integrations."""
