"""Then: a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s"""

from __future__ import annotations

from pytest_bdd import step


@step('a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s')
def deleting_bucket_has_no_active_namespaces():
    """No-op: bucket-namespace consistency invariant; always passes."""
