"""Given: the resource does not have a path"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the resource does not have a path")
def resource_does_not_have_path(world):
    pytest.skip("Cannot create a resource without a path in stateless integration tests.")
