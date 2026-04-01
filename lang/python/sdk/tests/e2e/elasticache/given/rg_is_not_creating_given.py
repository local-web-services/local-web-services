"""Given: the "elasticache" "replication group" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "replication group" was not "CREATING"')
def rg_is_not_creating_given():
    """No-op: replication groups are not in CREATING state by default."""
