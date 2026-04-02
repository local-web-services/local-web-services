"""Given: the "s3" "bucket" has no "eventbridge" notification configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "s3" "bucket" has no "eventbridge" notification configured')
def bucket_has_no_eventbridge_notification():
    """No-op: no notification configured by default."""
