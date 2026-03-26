"""Given: fid in func_has_policy"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("fid in func_has_policy")
def fid_in_func_has_policy(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
