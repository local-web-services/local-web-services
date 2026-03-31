"""Given: the "elasticache" "cluster" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" did not exist')
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""
