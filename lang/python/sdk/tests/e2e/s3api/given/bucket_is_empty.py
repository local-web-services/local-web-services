"""Given: the "s3" "bucket" was empty"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "bucket" was empty')
def bucket_is_empty():
    """No-op: freshly created bucket is empty."""
