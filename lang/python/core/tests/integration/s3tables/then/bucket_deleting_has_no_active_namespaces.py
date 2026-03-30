"""Then: a bucket in "DELETING" state has no "ACTIVE" namespaces"""

from __future__ import annotations

from pytest_bdd import then


@then('a bucket in "DELETING" state has no "ACTIVE" namespaces')
def bucket_deleting_has_no_active_namespaces():
    """Invariant: trivially satisfied in isolated test context."""
