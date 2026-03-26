"""Given: the connection slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the connection slot is not available")
def connection_slot_not_available(world):
    pytest.skip("Connection slot limits are not configurable in stateless integration tests.")
