"""Given: bname not in bucket_status"""

from __future__ import annotations

from pytest_bdd import given


@given("bname not in bucket_status")
def bname_not_in_bucket_status():
    """No-op: symbolic precondition from FizzBee model; fresh state has no buckets."""
