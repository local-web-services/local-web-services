"""Given: the new primary instance does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the new primary instance does not exist")
def new_primary_instance_does_not_exist(world):
    pytest.skip("Cannot configure failover target in integration tests.")
