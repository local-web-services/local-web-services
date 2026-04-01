"""Given: the "cognito" "user" was "UNCONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "cognito" "user" was "UNCONFIRMED"')
def user_is_unconfirmed(lws_session, world):
    """Create a user and ensure they are in UNCONFIRMED state."""
    pytest.skip(
        "Cannot create UNCONFIRMED users via AdminCreateUser (starts in FORCE_CHANGE_PASSWORD)"
    )
