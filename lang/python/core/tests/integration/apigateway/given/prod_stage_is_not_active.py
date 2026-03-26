"""Given: the prod stage is not active"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the prod stage is not active")
def prod_stage_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
