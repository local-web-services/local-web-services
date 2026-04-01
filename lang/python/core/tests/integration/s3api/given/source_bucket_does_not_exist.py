"""Given: the source "s3" "bucket" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the source "s3" "bucket" did not exist')
def source_bucket_does_not_exist():
    """No-op: fresh state has no buckets."""
