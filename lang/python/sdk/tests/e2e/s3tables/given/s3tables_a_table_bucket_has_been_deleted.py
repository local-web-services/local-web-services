"""Given: a table bucket has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET


@given("a table bucket has been deleted")
def s3tables_a_table_bucket_has_been_deleted(lws_session):
    try:
        resp = S3tablesTestClient(lws_session).create_bucket()
        bucket_arn = resp.get("arn", TEST_BUCKET)
    except Exception:
        bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
    try:
        S3tablesTestClient(lws_session).delete_table_bucket(tableBucketARN=bucket_arn)
    except Exception:
        pass
