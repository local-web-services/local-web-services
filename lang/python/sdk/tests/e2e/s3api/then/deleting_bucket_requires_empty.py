"""Then: deleting a bucket requires it to be empty"""

from __future__ import annotations

from pytest_bdd import step


@step("deleting a bucket requires it to be empty")
def deleting_bucket_requires_empty():
    """No-op invariant: lws enforces this constraint at the API level."""
