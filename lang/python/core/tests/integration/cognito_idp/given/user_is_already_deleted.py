"""Given: the user is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is already "DELETED"')
def user_is_already_deleted(world):
    pytest.skip(
        "Lifecycle-dependent state (already DELETED user) is not supported "
        "in stateless integration tests."
    )
