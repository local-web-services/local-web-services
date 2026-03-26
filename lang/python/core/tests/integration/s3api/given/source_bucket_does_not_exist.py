"""Given: the source bucket does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the source bucket does not exist")
def source_bucket_does_not_exist():
    """No-op: fresh state has no buckets."""
