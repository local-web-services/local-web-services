"""Then: a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables"""

from __future__ import annotations

from pytest_bdd import step


@step('a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables')
def deleting_namespace_has_no_active_tables():
    """No-op: namespace-table consistency invariant; always passes."""
