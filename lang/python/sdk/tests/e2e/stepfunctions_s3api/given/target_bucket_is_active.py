"""Given: the target bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target bucket is "ACTIVE"')
def target_bucket_is_active():
    """No-op: buckets are ACTIVE by default after creation."""
