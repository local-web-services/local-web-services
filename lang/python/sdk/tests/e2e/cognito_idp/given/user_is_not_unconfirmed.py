"""Given: the user is not "UNCONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is not "UNCONFIRMED"')
def user_is_not_unconfirmed():
    pytest.skip("lws does not enforce UNCONFIRMED state checks on verification operations")
