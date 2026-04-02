"""Given: no "neptune" "snapshot" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "rds" "snapshot" slot is available')
@given('no "neptune" "snapshot" "slot" was "available"')
def no_snapshot_slot_available(world):
    pytest.skip("Snapshot slot limits are not configurable in stateless integration tests.")
