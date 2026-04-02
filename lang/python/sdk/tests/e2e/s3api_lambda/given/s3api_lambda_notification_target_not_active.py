"""Given: the notification target "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the notification target "lambda" "function" was not "ACTIVE"')
def s3api_lambda_notification_target_not_active(world):
    world["_skip"] = (
        "lws does not fail put_object when the S3 notification target Lambda function"
        " is in CREATING lifecycle state"
    )
    pytest.skip(world["_skip"])
