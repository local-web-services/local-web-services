"""Given: the async slot is occupied"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the async slot is occupied")
def async_slot_is_occupied(world):
    pytest.skip("Cannot pre-fill async slots in integration tests.")
