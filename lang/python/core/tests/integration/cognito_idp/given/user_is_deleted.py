"""Given: the "cognito" "user" was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was "DELETED"')
def user_is_deleted(world):
    pytest.skip(
        "Lifecycle-dependent state (DELETED user) is not supported "
        "in stateless integration tests."
    )
