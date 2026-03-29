"""Given: cid in tag_exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("cid in tag_exists")
def cid_in_tag_exists(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")
