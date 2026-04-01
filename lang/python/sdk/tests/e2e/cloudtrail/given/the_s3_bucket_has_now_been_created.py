"""Given: the S3 bucket has now been created"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_BUCKET_2


@given("the S3 bucket has now been created")
def the_s3_bucket_has_now_been_created(lws_session):
    s3 = lws_session.client("s3")
    try:
        s3.create_bucket(Bucket=TEST_BUCKET_2)
    except Exception:
        pass
