"""Given: the group is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the group is "ACTIVE"')
def group_is_active():
    """No-op: groups are ACTIVE immediately after creation."""
