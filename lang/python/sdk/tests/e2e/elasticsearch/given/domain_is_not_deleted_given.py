"""Given: the domain is not deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("the domain is not deleted")
def domain_is_not_deleted_given():
    """No-op: domains are not deleted by default."""
