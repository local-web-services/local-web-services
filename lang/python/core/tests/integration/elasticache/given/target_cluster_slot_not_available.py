"""Given: the target cluster slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the target cluster slot is not available")
def target_cluster_slot_not_available(world):
    pytest.skip("Cannot exhaust cluster slots in integration tests.")
