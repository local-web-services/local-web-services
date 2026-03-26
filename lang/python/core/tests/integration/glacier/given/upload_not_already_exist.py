"""Given: the upload does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the upload does not already exist")
def upload_not_already_exist():
    """No-op: fresh state has no uploads."""
