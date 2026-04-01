"""Given: the "memorydb" "user" membership entry did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "user" membership entry did not exist')
def user_membership_entry_does_not_exist():
    """No-op: fresh state has no user membership entries."""
