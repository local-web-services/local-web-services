"""When: an object is uploaded but notification delivery fails because the topic has been deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when("an object is uploaded but notification delivery fails because the topic has been deleted")
def put_object_notification_fails(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
