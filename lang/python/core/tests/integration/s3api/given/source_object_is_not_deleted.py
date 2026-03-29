"""Given: the source object is not deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("the source object is not deleted")
def source_object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""
