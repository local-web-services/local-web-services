"""Given: the "cognito" "user" will be "DISABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was "DISABLED"')
@given('the "cognito" "user" will be "DISABLED"')
def user_is_disabled(world):
    pytest.skip(
        "Lifecycle-dependent state (disabled user) is not supported "
        "in stateless integration tests."
    )
