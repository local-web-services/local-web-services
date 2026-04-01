"""When: PutObject is called on the S3 provider"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_S3_BUCKET, TEST_S3_KEY


@when("PutObject is called on the S3 provider")
def put_object_is_called_on_the_s3_provider(lws_session, world):
    s3 = lws_session.client("s3")
    try:
        s3.create_bucket(Bucket=TEST_S3_BUCKET)
    except Exception:
        pass
    try:
        world["result"] = s3.put_object(Bucket=TEST_S3_BUCKET, Key=TEST_S3_KEY, Body=b"test-data")
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
