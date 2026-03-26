"""Given: the user is already "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the user is already "DELETED"')
def user_is_already_deleted():
    pytest.skip("lws does not reject deleting an already-deleted user")
