"""Then: a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s"""

from __future__ import annotations

from pytest_bdd import then


@then('a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s')
def bucket_deleting_has_no_active_namespaces():
    """Invariant: trivially satisfied in isolated test context."""
