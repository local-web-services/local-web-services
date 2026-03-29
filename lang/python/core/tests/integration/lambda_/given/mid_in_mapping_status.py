"""Given: mid in mapping_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("mid in mapping_status")
def mid_in_mapping_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
