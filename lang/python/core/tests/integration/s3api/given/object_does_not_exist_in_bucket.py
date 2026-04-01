"""Given: the "s3" "object" did not exist in the "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "object" did not exist in the "s3" "bucket"')
def object_does_not_exist_in_bucket():
    """No-op: fresh bucket has no objects."""
