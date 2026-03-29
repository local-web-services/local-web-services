"""Given: the destination bucket exists"""

from __future__ import annotations

from pytest_bdd import given


@given("the destination bucket exists")
def destination_bucket_exists():
    """No-op: destination bucket (INT_BUCKET) was created in source_bucket_exists."""
