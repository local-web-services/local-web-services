"""Given: the "s3" "bucket" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "bucket" was "ACTIVE"')
def bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""
