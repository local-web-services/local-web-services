"""Given: the "s3" "upload" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "upload" did not already exist')
def upload_not_already_exist():
    """No-op: no uploads in progress."""
