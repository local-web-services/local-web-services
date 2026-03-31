"""Given: the "s3" "bucket" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" was "ACTIVE"')
@given('the "s3" "bucket" will be "ACTIVE"')
def bucket_is_active():
    """No-op: in lws, buckets are ACTIVE immediately after creation."""
