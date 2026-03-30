"""Given: the notification target function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the notification target function is "ACTIVE"')
def s3api_lambda_notification_target_active():
    """No-op: Lambda functions are ACTIVE immediately after creation."""
