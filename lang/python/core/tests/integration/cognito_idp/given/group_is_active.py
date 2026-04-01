"""Given: the "cognito" "group" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "group" was "ACTIVE"')
def group_is_active():
    """No-op: groups are always ACTIVE after creation."""
