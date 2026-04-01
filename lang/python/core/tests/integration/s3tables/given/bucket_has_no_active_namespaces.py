"""Given: the "s3 tables" "bucket" had no active namespaces"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" had no active namespaces')
def bucket_has_no_active_namespaces():
    """No-op: fresh bucket has no namespaces."""
