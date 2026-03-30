"""Given: the user is enabled"""

from __future__ import annotations

from pytest_bdd import given


@given("the user is enabled")
def user_is_enabled(lws_session, world):
    """No-op: users created via AdminCreateUser are enabled by default."""
