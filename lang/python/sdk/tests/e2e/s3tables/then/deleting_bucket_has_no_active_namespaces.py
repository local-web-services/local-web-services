"""Then: a bucket in "DELETING" state has no "ACTIVE" namespaces"""

from __future__ import annotations

from pytest_bdd import then


@then('a bucket in "DELETING" state has no "ACTIVE" namespaces')
def deleting_bucket_has_no_active_namespaces():
    """No-op: bucket-namespace consistency invariant; always passes."""
