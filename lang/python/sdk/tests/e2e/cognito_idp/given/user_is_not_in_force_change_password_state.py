"""Given: the "cognito" "user" is not in "FORCE_CHANGE_PASSWORD" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" is not in "FORCE_CHANGE_PASSWORD" state')
def user_is_not_in_force_change_password_state():
    pytest.skip("Cannot set user to non-FORCE_CHANGE_PASSWORD state without auth flow")
