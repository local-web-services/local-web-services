"""Given: the archive does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the archive does not already exist")
def archive_not_already_exist():
    """No-op: fresh state has no archives."""
