"""Given: the "cognito" "user" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "user" was "ENABLED"')
def user_is_enabled(lws_session, world):
    """No-op: users created via AdminCreateUser are enabled by default."""
