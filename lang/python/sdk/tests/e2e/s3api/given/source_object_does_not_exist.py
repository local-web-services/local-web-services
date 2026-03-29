"""Given: the source object does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the source object does not exist")
def source_object_does_not_exist():
    """No-op: no object in source bucket by default."""
