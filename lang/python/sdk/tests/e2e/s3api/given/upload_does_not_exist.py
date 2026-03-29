"""Given: the upload does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the upload does not exist")
def upload_does_not_exist():
    """No-op: no uploads in progress by default."""
