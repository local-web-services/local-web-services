"""Given: the bucket is empty"""

from __future__ import annotations

from pytest_bdd import given


@given("the bucket is empty")
def bucket_is_empty():
    """No-op: freshly created bucket is empty."""
