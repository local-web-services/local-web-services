"""Given: the "s3 tables" "bucket" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "s3 tables" "bucket" was "ACTIVE"')
def bucket_is_active_given():
    """No-op: lws returns buckets as ACTIVE immediately after creation."""
