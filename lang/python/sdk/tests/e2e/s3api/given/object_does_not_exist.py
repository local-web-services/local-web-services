"""Given: the object does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the object does not exist")
def object_does_not_exist():
    """No-op: fresh bucket has no objects."""
