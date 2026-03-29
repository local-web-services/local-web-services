"""Given: the user is not "FORCE_CHANGE_PASSWORD" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is not "FORCE_CHANGE_PASSWORD"')
def user_is_not_force_change_password():
    pytest.skip("Cannot set user to non-FORCE_CHANGE_PASSWORD state without auth flow")
