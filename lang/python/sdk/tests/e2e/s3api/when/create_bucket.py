"""When: a bucket is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@when("a bucket is created")
def create_bucket(lws_session, world):
    try:
        world["result"] = S3apiTestClient(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
