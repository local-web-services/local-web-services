"""Given: the source "s3" "object" is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the source "s3" "object" is not "DELETED"')
def source_object_is_not_deleted():
    """No-op: objects are not deleted by default after being put."""
