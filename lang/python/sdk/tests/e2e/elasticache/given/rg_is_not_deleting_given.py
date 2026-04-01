"""Given: the "elasticache" "replication group" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "replication group" was not "DELETING"')
def rg_is_not_deleting_given():
    """No-op: replication groups are not in DELETING state by default."""
