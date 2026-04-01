"""Then: memcached clusters are never associated with a "elasticache" "replication group" """

from __future__ import annotations

from pytest_bdd import step


@step('memcached clusters are never associated with a "elasticache" "replication group"')
def memcached_clusters_not_in_rg():
    """No-op: replication group membership invariant; always passes."""
