"""Given: the "cognito" "user" was not "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was not "ENABLED"')
def user_is_not_enabled(world):
    pytest.skip(
        "Lifecycle-dependent state (disabled user) is not supported "
        "in stateless integration tests."
    )
