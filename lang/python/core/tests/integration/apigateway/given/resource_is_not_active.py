"""Given: the "api gateway" "resource" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "resource" was not "ACTIVE"')
def resource_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
