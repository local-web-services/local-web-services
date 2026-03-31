"""Given: the "memorydb" "user" was not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" was not "MODIFYING"')
def user_is_not_modifying_given():
    """No-op: users are not in MODIFYING state by default."""
