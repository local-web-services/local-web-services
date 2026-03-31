"""Given: the destination "s3" "bucket" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the destination "s3" "bucket" was "ACTIVE"')
def destination_bucket_is_active_given():
    """No-op: destination bucket is ACTIVE by default after creation."""
