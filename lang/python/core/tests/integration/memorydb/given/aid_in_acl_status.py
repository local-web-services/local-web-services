"""Given: aid in acl_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("aid in acl_status")
def aid_in_acl_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
