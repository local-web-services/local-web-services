"""Given: no resource slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no resource slot is available")
def no_resource_slot_available(world):
    pytest.skip("Cannot exhaust resource slots in stateless integration tests.")
