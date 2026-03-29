"""Given: the source object's bucket exists"""

from __future__ import annotations

from pytest_bdd import given


@given("the source object's bucket exists")
def source_objects_bucket_exists():
    """No-op: bucket was created in source_bucket_exists step."""
