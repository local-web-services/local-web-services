"""Given: the "s3 tables" "table" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "table" did not already exist')
def table_not_already_exist():
    """No-op: fresh state has no S3 Tables table buckets."""
