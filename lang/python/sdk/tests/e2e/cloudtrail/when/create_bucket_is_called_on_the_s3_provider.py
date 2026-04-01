"""When: CreateBucket is called on the S3 provider"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_S3_BUCKET


@when("CreateBucket is called on the S3 provider")
def create_bucket_is_called_on_the_s3_provider(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").create_bucket(Bucket=TEST_S3_BUCKET)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
