"""Given: slot in async_func"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("slot in async_func")
def slot_in_async_func(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
