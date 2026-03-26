"""Given: the snapshot slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the snapshot slot is not available")
def snapshot_slot_not_available(world):
    pytest.skip("Cannot exhaust snapshot slots in integration tests.")
