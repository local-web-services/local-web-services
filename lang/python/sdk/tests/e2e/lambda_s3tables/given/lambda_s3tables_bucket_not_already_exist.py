"""Given: the "s3" "bucket" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "bucket" did not already exist')
def lambda_s3tables_bucket_not_already_exist():
    """No-op: fresh state has no S3 table buckets."""
