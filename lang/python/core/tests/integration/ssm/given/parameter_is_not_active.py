"""Given: the parameter is not active"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the parameter is not active")
def parameter_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
