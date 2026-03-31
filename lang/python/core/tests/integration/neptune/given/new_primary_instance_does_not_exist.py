"""Given: the new primary "documentdb" "instance" did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the new primary "documentdb" "instance" did not exist')
def new_primary_instance_does_not_exist(world):
    pytest.skip("Primary instance promotion is not available in stateless integration tests.")
