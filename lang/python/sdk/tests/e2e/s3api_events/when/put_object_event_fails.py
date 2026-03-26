"""When: an object is uploaded but event delivery fails because the bus has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiEventsTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when("an object is uploaded but event delivery fails because the bus has been deleted")
def put_object_event_fails(lws_session, world):
    try:
        world["result"] = S3apiEventsTestClient(lws_session)._s3.put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
