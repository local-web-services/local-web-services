"""Given: the "s3" "bucket" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" did not already exist')
@given('the "s3" "bucket" did not already exist')
def bucket_does_not_already_exist():
    """No-op: fresh provider has no buckets."""
