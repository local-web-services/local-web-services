"""When: a "s3" "bucket" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaS3apiTestClient
from ..constants import TEST_BUCKET


@when('a "s3" "bucket" is created')
def create_s3_bucket(lws_session, world):
    try:
        LambdaS3apiTestClient(lws_session).create_bucket()
        world["result"] = {"Bucket": TEST_BUCKET}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
