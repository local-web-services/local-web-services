"""Given: no execution slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")
