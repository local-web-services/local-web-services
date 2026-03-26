"""Given: the cluster does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""
