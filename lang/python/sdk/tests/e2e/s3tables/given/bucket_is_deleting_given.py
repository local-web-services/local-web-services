"""Given: the "s3 tables" "bucket" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET


@given('the "s3 tables" "bucket" was "DELETING"')
def bucket_is_deleting_given(lws_session):
    try:
        S3tablesTestClient(lws_session).create_bucket()
    except Exception:
        pass
    resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
    actual_arn = resp.get("arn", TEST_BUCKET)
    lws_session.lifecycle("s3tables").delete_dwell_ms(5000).apply()
    lws_session.client("s3tables").delete_table_bucket(tableBucketARN=actual_arn)
