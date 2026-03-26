"""Given: the domain is not being deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("the domain is not being deleted")
def domain_not_being_deleted():
    """No-op: domains are not being deleted in fresh state."""
