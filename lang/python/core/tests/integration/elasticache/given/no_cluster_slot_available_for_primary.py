"""Given: no "elasticache" "cluster" slot is available for the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "elasticache" "cluster" slot is available for the primary')
def no_cluster_slot_available_for_primary(world):
    pytest.skip("Cannot exhaust cluster slots in integration tests.")
