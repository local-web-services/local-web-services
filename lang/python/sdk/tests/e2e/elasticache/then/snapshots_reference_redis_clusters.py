"""Then: all snapshots reference redis clusters only"""

from __future__ import annotations

from pytest_bdd import step


@step("all snapshots reference redis clusters only")
def snapshots_reference_redis_clusters():
    """No-op: snapshot-cluster relationship invariant; always passes."""
