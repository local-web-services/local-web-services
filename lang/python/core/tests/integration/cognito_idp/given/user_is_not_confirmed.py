"""Given: the user is not "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is not "CONFIRMED"')
def user_is_not_confirmed(world):
    pytest.skip(
        "Lifecycle-dependent state (user not CONFIRMED) is not supported "
        "in stateless integration tests."
    )
