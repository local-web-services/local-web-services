"""Given: mid not in mapping_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("mid not in mapping_status")
def mid_not_in_mapping_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
