"""Given: the table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the table is "ACTIVE"')
def table_is_active_given():
    """No-op: S3 Tables table buckets are ACTIVE immediately after creation."""
