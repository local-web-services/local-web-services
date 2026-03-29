"""Given: sgid in sg_exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("sgid in sg_exists")
def sgid_in_sg_exists(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
