"""Given: the replication group is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the replication group is not "CREATING"')
def rg_is_not_creating_given():
    """No-op: replication groups are not in CREATING state by default."""
