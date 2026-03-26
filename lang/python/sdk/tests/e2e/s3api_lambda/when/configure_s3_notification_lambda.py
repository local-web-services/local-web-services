"""When: an S3 event notification is configured to invoke a Lambda function on object "PUT" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiLambdaTestClient
from ..constants import FUNC_ARN, TEST_BUCKET


@when('an S3 event notification is configured to invoke a Lambda function on object "PUT"')
def configure_s3_notification_lambda(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = S3apiLambdaTestClient(lws_session)._s3.put_bucket_notification_configuration(
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
