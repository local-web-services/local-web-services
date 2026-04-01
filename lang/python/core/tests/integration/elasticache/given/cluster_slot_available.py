"""Given: an "elasticache" "cluster" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('an "elasticache" "cluster" slot is available')
def cluster_slot_available():
    """No-op: lws does not enforce cluster slot limits."""
