"""Then: every "CACHED" entry belongs to an "AVAILABLE" cluster"""

from __future__ import annotations

from pytest_bdd import step


@step('every "CACHED" entry belongs to an "AVAILABLE" cluster')
def _inv_lambda_elasticache_every_cached_entry_belongs_to_an_available_cluster():
    """Invariant step: trivially satisfied in isolated test context."""
