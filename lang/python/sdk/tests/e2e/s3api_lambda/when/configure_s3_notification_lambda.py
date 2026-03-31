"""When: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import FUNC_ARN, TEST_BUCKET


@when('a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"')
def configure_s3_notification_lambda(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = lws_session.client("s3").put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={
                "LambdaFunctionConfigurations": [
                    {"LambdaFunctionArn": FUNC_ARN, "Events": ["s3:ObjectCreated:*"]}
                ]
            },
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
