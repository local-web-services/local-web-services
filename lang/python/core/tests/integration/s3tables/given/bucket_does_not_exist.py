"""Given: the "s3" "bucket" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" did not exist')
@given('the "s3" "bucket" did not exist')
def bucket_does_not_exist():
    """No-op: fresh provider has no buckets."""
