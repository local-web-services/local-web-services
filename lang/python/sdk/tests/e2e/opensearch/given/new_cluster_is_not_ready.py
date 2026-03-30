"""Given: the new cluster is not ready"""

from __future__ import annotations

from pytest_bdd import given


@given("the new cluster is not ready")
def new_cluster_is_not_ready():
    """No-op: no ready new cluster by default."""
