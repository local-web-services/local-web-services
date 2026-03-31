"""Given: the source "s3" "object" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the source "s3" "object" did not exist')
def source_object_does_not_exist():
    """No-op: no object in source bucket by default."""
