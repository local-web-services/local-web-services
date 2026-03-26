"""When: an object is retrieved from the bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_KEY


@when("an object is retrieved from the bucket")
def get_object_old(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").get_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
