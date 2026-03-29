"""Given: the user pool is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user pool is not "ACTIVE"')
def pool_is_not_active_given(lws_session, world):
    pytest.skip("lws does not enforce lifecycle state for user pool operations")
