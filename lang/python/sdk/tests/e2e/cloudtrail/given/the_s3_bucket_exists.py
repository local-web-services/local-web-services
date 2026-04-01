"""Given: the S3 bucket exists"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_BUCKET


@given("the S3 bucket exists")
def the_s3_bucket_exists(lws_session):
    s3 = lws_session.client("s3")
    try:
        s3.create_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass
