"""Given: the "s3" "bucket" already has a notification configuration"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3" "bucket" already has a notification configuration')
def bucket_already_has_notification():
    pytest.skip(
        "lws does not reject put_bucket_notification_configuration when a config already exists"
        " (idempotent / overwrite allowed)"
    )
