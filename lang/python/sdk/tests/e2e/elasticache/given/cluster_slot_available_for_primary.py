"""Given: an "elasticache" "cluster" slot is available for the primary"""

from __future__ import annotations

from pytest_bdd import given


@given('an "elasticache" "cluster" slot is available for the primary')
def cluster_slot_available_for_primary():
    """No-op: always room for primary clusters."""
