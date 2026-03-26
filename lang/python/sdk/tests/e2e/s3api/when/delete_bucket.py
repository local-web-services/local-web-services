"""When: a bucket is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET


@when("a bucket is deleted")
def delete_bucket(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").delete_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
