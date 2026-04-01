"""Given: the "api gateway" "API" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "API" was not "ACTIVE"')
def api_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
