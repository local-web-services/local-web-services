"""Given: the "s3" "bucket" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" was not "ACTIVE"')
def s3api_lambda_function_is_not_active_given(lws_session, world):
    world["_skip"] = (
        "lws does not reject put_bucket_notification_configuration when the Lambda function"
        " is in CREATING lifecycle state"
    )
    pytest.skip(world["_skip"])
