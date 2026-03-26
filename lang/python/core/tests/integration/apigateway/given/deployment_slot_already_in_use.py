"""Given: the deployment slot is already in use"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the deployment slot is already in use")
def deployment_slot_already_in_use(world):
    pytest.skip("Cannot force a deployment slot collision in stateless integration tests.")
