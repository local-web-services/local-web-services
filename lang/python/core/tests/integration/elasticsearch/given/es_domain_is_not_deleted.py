"""Given: the domain is not deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("the domain is not deleted")
def es_domain_is_not_deleted():
    """No-op: domains are not deleted in fresh state."""
