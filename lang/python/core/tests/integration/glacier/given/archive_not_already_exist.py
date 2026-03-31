"""Given: the "glacier" "archive" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "archive" did not already exist')
def archive_not_already_exist():
    """No-op: fresh vault has no archives."""
