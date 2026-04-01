"""Given: the "elasticache" "cluster" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "cluster" was "AVAILABLE"')
def cluster_is_available_given():
    """No-op: ElastiCache clusters are AVAILABLE immediately after creation."""
