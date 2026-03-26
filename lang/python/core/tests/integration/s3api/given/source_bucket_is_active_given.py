"""Given: the source bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the source bucket is "ACTIVE"')
def source_bucket_is_active_given():
    """No-op: source buckets are ACTIVE by default after creation."""
