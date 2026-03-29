"""Given: the instance is not the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the instance is not the primary")
def instance_is_not_the_primary(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")
