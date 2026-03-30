"""Given: no cluster slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no cluster slot is available")
def no_cluster_slot_available(world):
    pytest.skip("Cannot exhaust cluster slots in integration tests.")
