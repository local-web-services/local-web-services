"""Given: the user is not disabled"""

from __future__ import annotations

from pytest_bdd import given


@given("the user is not disabled")
def user_is_not_disabled():
    """No-op: users created via AdminCreateUser are enabled (not disabled) by default."""
