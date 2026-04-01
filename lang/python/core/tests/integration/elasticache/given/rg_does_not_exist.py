"""Given: the "elasticache" "replication group" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "replication group" did not exist')
def rg_does_not_exist():
    """No-op: fresh state has no replication groups."""
