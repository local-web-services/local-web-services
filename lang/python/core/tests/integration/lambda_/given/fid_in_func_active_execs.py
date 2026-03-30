"""Given: fid in func_active_execs"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("fid in func_active_execs")
def fid_in_func_active_execs(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
