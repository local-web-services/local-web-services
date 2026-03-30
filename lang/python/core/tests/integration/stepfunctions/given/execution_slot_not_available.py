"""Given: the execution slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the execution slot is not available")
def execution_slot_not_available():
    pytest.skip("Cannot exhaust execution slot limit in integration test context")
