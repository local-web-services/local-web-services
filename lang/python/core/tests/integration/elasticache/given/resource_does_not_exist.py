"""Given: the resource does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the resource does not exist")
def resource_does_not_exist():
    """No-op: fresh state has no resources."""
