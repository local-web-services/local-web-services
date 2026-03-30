"""Given: no async slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no async slot is available")
def no_async_slot_available(world):
    pytest.skip("Cannot exhaust async slots in integration tests.")
