"""Given: the new primary instance exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the new primary instance exists")
def new_primary_instance_exists(world):
    pytest.skip("Primary instance promotion is not available in stateless integration tests.")
