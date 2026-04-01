"""Given: the bucket did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the bucket did not exist or was "ACTIVE"')
def bucket_not_exist_or_not_active():
    """No-op: fresh state has no buckets."""
