"""Given: fid in func_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("fid in func_status")
def fid_in_func_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
