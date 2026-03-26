"""Given: the user is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is not "ACTIVE"')
def user_is_not_active(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")
