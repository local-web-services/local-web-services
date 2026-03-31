"""Given: the "memorydb" "user" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" was "ACTIVE"')
@given('the "memorydb" "user" will be "ACTIVE"')
def user_is_active():
    """No-op: users are ACTIVE immediately after creation in lws."""
