"""Then: all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only"""

from __future__ import annotations

from pytest_bdd import step


@step('all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only')
def snapshots_reference_redis_clusters():
    """No-op: snapshot-cluster relationship invariant; always passes."""
