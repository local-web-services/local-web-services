"""When: an object is uploaded and S3 publishes a notification to the "SNS" topic"""

from __future__ import annotations

import pytest
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when('an object is uploaded and S3 publishes a notification to the "SNS" topic')
def put_object_with_sns_notification(lws_session, world):
    if world.get("_target_topic_deleted"):
        pytest.skip(
            "lws uses fire-and-forget notification delivery: put_object always succeeds even when the notification target topic has been deleted"  # noqa: E501
        )
    try:
        world["result"] = lws_session.client("s3").put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
