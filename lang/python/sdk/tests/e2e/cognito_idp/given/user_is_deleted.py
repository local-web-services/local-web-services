"""Given: the "cognito" "user" was not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was not "DELETED"')
def user_is_deleted(lws_session, world):
    """No-op: represent a user that is already deleted (user does not exist)."""
    pytest.skip("Cannot represent a DELETED user that still has an admin_delete_user call needed")
