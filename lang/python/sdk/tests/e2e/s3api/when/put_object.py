"""When: an object is uploaded to a bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when("an object is uploaded to a bucket")
def put_object(lws_session, world):
    try:
        world["result"] = S3apiTestClient(lws_session).put_object(
            Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
