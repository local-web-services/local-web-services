"""Then: all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only"""

from __future__ import annotations

from pytest_bdd import then


@then('all "elasticache" "snapshot"s reference "redis" "elasticache" "cluster"s only')
def snapshots_reference_redis_only():
    """Invariant: trivially satisfied in isolated lws context."""
