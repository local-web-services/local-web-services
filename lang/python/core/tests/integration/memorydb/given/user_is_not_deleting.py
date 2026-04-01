"""Given: the "memorydb" "user" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" was not "DELETING"')
def user_is_not_deleting():
    """No-op: users are not in DELETING state by default."""
