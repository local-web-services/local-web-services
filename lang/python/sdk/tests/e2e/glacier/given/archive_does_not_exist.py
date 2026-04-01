"""Given: the "glacier" "archive" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "glacier" "archive" did not exist')
def archive_does_not_exist():
    """No-op: fresh state has no archives."""
