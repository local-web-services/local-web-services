"""Given: no item slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no item slot is available")
def no_item_slot_available():
    pytest.skip("Cannot exhaust item slot limit")
