"""Given: the domain is "CREATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the domain is "CREATING"')
def domain_is_creating(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
