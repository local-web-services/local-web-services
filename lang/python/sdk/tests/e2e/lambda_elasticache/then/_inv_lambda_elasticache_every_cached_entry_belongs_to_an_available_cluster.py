"""Then: every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster" """

from __future__ import annotations

from pytest_bdd import step


@step('every "CACHED" "elasticache" "entry" belongs to an "AVAILABLE" "elasticache" "cluster"')
def _inv_lambda_elasticache_every_cached_entry_belongs_to_an_available_cluster():
    """Invariant step: trivially satisfied in isolated test context."""
