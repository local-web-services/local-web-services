"""Given: the "cognito" "user" was not "UNCONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was not "UNCONFIRMED"')
def user_is_not_unconfirmed(world):
    pytest.skip(
        "Lifecycle-dependent state (user not UNCONFIRMED) is not supported "
        "in stateless integration tests."
    )
