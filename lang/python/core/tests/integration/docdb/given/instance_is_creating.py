"""Given: the instance is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "CREATING"')
def instance_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
