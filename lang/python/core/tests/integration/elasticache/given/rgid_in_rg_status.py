"""Given: rgid in rg_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("rgid in rg_status")
def rgid_in_rg_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
