"""Given: the async slot has a function assigned"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the async slot has a function assigned")
def async_slot_has_function(world):
    pytest.skip("Cannot pre-assign async slots in integration tests.")
