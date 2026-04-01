"""Given: the "cognito" "user pool" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user pool" was not "ACTIVE"')
def pool_is_not_active(world):
    pytest.skip(
        "Lifecycle-dependent state (non-ACTIVE pool) is not supported "
        "in stateless integration tests."
    )
