"""Given: the bucket does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the bucket does not already exist")
def bucket_does_not_already_exist():
    """No-op: fresh provider has no buckets."""
