"""Given: no "s3" "object" existed in the target "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given


@given('no "s3" "object" existed in the target "s3" "bucket"')
def no_object_exists_in_target_bucket(world):
    """No-op: fresh bucket has no objects."""
    world["_no_object_in_target_bucket"] = True
