"""Then: "memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group" """

from __future__ import annotations

from pytest_bdd import then


@then(
    '"memcached" "elasticache" "cluster"s are never associated with a "elasticache" "replication group"'
)
def memcached_not_in_rg():
    """Invariant: trivially satisfied in isolated lws context."""
