"""Given: the "s3 tables" "namespace" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET, TEST_NAMESPACE


@given('the "s3 tables" "namespace" was not "ACTIVE"')
def namespace_is_not_active_given(lws_session):
    try:
        S3tablesTestClient(lws_session).create_bucket()
    except Exception:
        pass
    resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
    bucket_arn = resp.get("arn", TEST_BUCKET)
    try:
        lws_session.client("s3tables").delete_namespace(
            tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE
        )
    except Exception:
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    lws_session.client("s3tables").create_namespace(
        tableBucketARN=bucket_arn, namespace=[TEST_NAMESPACE]
    )
