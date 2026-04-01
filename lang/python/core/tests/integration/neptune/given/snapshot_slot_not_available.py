"""Given: the "documentdb" "snapshot" slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "snapshot" slot is not available')
@given('the "documentdb" "snapshot" slot is not available')
def snapshot_slot_not_available(world):
    pytest.skip("Snapshot slot limits are not configurable in stateless integration tests.")
