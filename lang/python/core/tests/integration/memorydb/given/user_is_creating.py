"""Given: the "memorydb" "user" was "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" was "CREATING"')
def user_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
