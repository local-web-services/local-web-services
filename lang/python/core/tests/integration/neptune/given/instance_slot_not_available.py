"""Given: the instance slot is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the instance slot is not available")
def instance_slot_not_available(world):
    pytest.skip("Instance slot limits are not configurable in stateless integration tests.")
