"""When: a rolled-back "dynamodb" "transaction" is cleared"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a rolled-back "dynamodb" "transaction" is cleared')
def clear_rolled_back_transaction(world: dict):
    pytest.skip("Cannot trigger rolled-back transaction clearing in integration context")
