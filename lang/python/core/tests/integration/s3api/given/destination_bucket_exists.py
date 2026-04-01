"""Given: the destination "s3" "bucket" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('the destination "s3" "bucket" existed')
def destination_bucket_exists():
    """No-op: destination bucket (INT_BUCKET) was created in source_bucket_exists."""
