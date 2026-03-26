"""Given: the pool is "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the pool is "DELETED"')
def pool_is_deleted_given():
    """No-op: fresh state has no user pools (simulates deleted pool)."""
