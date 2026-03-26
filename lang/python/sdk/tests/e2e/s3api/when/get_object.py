"""When: an object is retrieved from a bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@when("an object is retrieved from a bucket")
def get_object(lws_session, world):
    try:
        world["result"] = S3apiTestClient(lws_session).get_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
