"""Given: the target "documentdb" "cluster" slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target "neptune" "cluster" slot is not available')
@given('the target "documentdb" "cluster" slot is not available')
def target_cluster_slot_not_available(world):
    pytest.skip("Cluster slot limits are not configurable in stateless integration tests.")
