"""Given: the new primary "documentdb" "instance" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the new primary "documentdb" "instance" existed')
def new_primary_instance_exists(world):
    pytest.skip("Primary instance promotion is not available in stateless integration tests.")
