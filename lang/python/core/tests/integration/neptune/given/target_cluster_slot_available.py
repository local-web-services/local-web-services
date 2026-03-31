"""Given: the target "documentdb" "cluster" slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given('the target "neptune" "cluster" slot is available')
@given('the target "documentdb" "cluster" slot is available')
def target_cluster_slot_available():
    """No-op: target cluster slots are always available in lws."""
