"""Given: the "s3" "bucket" has no notification configuration"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "bucket" has no notification configuration')
def bucket_has_no_notification():
    """No-op: no notification configured by default."""
