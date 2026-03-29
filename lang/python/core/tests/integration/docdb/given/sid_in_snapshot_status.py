"""Given: sid in snapshot_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("sid in snapshot_status")
def sid_in_snapshot_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
