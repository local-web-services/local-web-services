"""Given: the "elasticache" "replication group" was not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "replication group" was not "MODIFYING"')
def rg_is_not_modifying_given():
    """No-op: replication groups are not in MODIFYING state by default."""
