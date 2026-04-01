"""Given: the source "s3" "bucket" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the source "s3" "bucket" was "ACTIVE"')
def source_bucket_is_active_given():
    """No-op: source buckets are ACTIVE by default after creation."""
