"""Given: the "memorydb" "user" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" was "ACTIVE"')
def user_is_active_given():
    """No-op: users are ACTIVE immediately after creation in lws."""
