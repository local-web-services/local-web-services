"""Given: iid in instance_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("iid in instance_status")
def iid_in_instance_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
