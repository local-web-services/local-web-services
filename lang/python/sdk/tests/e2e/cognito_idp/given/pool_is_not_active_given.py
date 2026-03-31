"""Given: the "cognito" "user pool" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user pool" was not "ACTIVE"')
def pool_is_not_active_given(lws_session, world):
    pytest.skip("lws does not enforce lifecycle state for user pool operations")
