"""Given: the target "s3" "bucket" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target "s3" "bucket" was "ACTIVE"')
def target_bucket_is_active():
    """No-op: buckets are ACTIVE by default after creation."""
