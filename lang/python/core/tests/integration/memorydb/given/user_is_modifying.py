"""Given: the "memorydb" "user" was "MODIFYING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "user" was "MODIFYING"')
def user_is_modifying(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
