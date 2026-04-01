"""Given: the "glacier" "upload" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "upload" did not exist')
@given('the "glacier" "upload" did not exist')
def upload_does_not_exist():
    """No-op: no uploads in progress by default."""
