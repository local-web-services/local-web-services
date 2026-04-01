"""Given: the "elasticache" "cluster" did not exist or was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" did not exist or was "AVAILABLE"')
def cluster_not_exist_or_not_available():
    """No-op: fresh state has no clusters."""
