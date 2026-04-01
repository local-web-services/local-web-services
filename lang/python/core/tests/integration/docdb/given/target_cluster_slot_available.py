"""Given: the target "documentdb" "cluster" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the target "documentdb" "cluster" slot is available')
def target_cluster_slot_available():
    """No-op: lws does not enforce cluster slot limits."""
