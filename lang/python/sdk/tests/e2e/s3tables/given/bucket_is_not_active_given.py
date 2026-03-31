"""Given: the "s3 tables" "bucket" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET


@given('the "s3 tables" "bucket" was not "ACTIVE"')
def bucket_is_not_active_given(lws_session):
    try:
        S3tablesTestClient(lws_session).delete_table_bucket(tableBucketARN=TEST_BUCKET)
    except Exception:
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    S3tablesTestClient(lws_session).create_bucket()
