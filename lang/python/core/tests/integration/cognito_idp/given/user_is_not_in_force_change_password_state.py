"""Given: the user is not in "FORCE_CHANGE_PASSWORD" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is not in "FORCE_CHANGE_PASSWORD" state')
def user_is_not_in_force_change_password_state(world):
    pytest.skip(
        "Lifecycle-dependent state (not FORCE_CHANGE_PASSWORD) is not supported "
        "in stateless integration tests."
    )
