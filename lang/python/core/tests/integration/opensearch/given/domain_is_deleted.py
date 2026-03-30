"""Given: the domain is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the domain is deleted")
def domain_is_deleted(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
