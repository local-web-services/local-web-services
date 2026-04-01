"""Given: the "s3 tables" "namespace" had no active tables"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "namespace" had no active tables')
def namespace_has_no_active_tables():
    """No-op: fresh namespace has no tables."""
