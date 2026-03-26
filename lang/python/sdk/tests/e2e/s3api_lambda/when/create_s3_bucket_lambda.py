"""When: an S3 bucket is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiLambdaTestClient
from ..constants import TEST_BUCKET


@when("an S3 bucket is created")
def create_s3_bucket_lambda(lws_session, world):
    try:
        resp = S3apiLambdaTestClient(lws_session)._s3.create_bucket(Bucket=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
