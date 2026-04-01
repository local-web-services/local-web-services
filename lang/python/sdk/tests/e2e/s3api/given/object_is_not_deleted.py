"""Given: the "s3" "object" was not "deleted" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "object" was not "deleted"')
def object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""
