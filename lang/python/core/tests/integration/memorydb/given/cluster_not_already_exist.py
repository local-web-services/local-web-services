"""Given: the "documentdb" "cluster" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "cluster" did not already exist')
@given('the "documentdb" "cluster" did not already exist')
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""
