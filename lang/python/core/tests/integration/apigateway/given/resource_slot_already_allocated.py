"""Given: the resource slot is already allocated"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the resource slot is already allocated")
def resource_slot_already_allocated(world):
    pytest.skip("Cannot force a resource slot collision in stateless integration tests.")
