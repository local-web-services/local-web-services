"""Given: the "elasticache" "cluster" is standalone (not part of a "elasticache" "replication group")"""

from __future__ import annotations

from pytest_bdd import given


@given(
    'the "elasticache" "cluster" is standalone (not part of a "elasticache" "replication group")'
)
def cluster_is_standalone():
    """No-op: clusters are standalone by default."""
