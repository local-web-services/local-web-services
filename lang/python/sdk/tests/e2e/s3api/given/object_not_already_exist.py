"""Given: the object does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the object does not already exist")
def object_not_already_exist():
    """No-op: fresh bucket has no objects."""
