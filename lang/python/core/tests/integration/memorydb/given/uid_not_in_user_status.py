"""Given: uid not in user_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("uid not in user_status")
def uid_not_in_user_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
