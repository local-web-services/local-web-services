"""Given: no delivery slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no delivery slot is available")
def delivery_slot_not_available():
    pytest.skip("Cannot exhaust delivery slot limit")
