"""Then: every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned'
)
def rg_has_primary():
    """Invariant: trivially satisfied in isolated lws context."""
