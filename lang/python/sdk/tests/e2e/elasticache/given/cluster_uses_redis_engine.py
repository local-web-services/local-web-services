"""Given: the cluster uses the redis engine"""

from __future__ import annotations

from pytest_bdd import given


@given("the cluster uses the redis engine")
def cluster_uses_redis_engine():
    """No-op: default cluster uses redis engine."""
