"""Given: no object slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no object slot is available")
def no_object_slot_available():
    pytest.skip("Cannot exhaust object slot limit")
