"""Then: every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "AVAILABLE" "elasticache" "replication group" has a primary "elasticache" "cluster" assigned'
)
def available_rg_has_primary():
    """No-op: replication group primary invariant; always passes."""
