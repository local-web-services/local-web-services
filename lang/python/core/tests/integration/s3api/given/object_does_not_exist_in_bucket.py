"""Given: the object does not exist in the bucket"""

from __future__ import annotations

from pytest_bdd import given


@given("the object does not exist in the bucket")
def object_does_not_exist_in_bucket():
    """No-op: fresh bucket has no objects."""
