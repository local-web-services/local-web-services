"""Given: the bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the bucket is "ACTIVE"')
def bucket_is_active():
    """No-op: in lws, buckets are ACTIVE immediately after creation."""
