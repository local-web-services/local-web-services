"""Given: pgid in pg_exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("pgid in pg_exists")
def pgid_in_pg_exists(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
