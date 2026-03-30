"""Given: the user is enabled"""

from __future__ import annotations

from pytest_bdd import given


@given("the user is enabled")
def user_is_enabled():
    """No-op: users start enabled after AdminCreateUser."""
