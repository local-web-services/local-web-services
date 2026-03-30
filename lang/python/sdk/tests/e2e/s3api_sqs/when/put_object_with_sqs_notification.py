"""When: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue"""

from __future__ import annotations

import pytest
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when('an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue')
def put_object_with_sqs_notification(lws_session, world):
    if world.get("_target_queue_deleted"):
        pytest.skip(
            "lws uses fire-and-forget notification delivery: put_object always succeeds even when the notification target queue has been deleted"  # noqa: E501
        )
    try:
        world["result"] = lws_session.client("s3").put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
