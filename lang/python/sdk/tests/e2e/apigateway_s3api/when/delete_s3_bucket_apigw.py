"""When: the S3 bucket is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayS3apiTestClient
from ..constants import TEST_BUCKET


@when("the S3 bucket is deleted")
def delete_s3_bucket_apigw(lws_session, world):
    try:
        resp = ApigatewayS3apiTestClient(lws_session)._s3.delete_bucket(Bucket=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
