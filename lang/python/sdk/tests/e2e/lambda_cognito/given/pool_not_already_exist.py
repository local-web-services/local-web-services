"""Given: the pool does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the pool does not already exist")
def pool_not_already_exist():
    """No-op: fresh state has no pools."""
