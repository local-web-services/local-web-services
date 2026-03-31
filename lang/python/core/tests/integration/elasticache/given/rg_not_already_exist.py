"""Given: the "elasticache" "replication group" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "replication group" did not already exist')
def rg_not_already_exist():
    """No-op: fresh state has no replication groups."""
