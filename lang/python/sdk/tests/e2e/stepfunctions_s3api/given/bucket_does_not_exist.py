"""Given: the bucket did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the bucket did not exist")
def bucket_does_not_exist():
    """No-op: fresh state has no buckets."""
