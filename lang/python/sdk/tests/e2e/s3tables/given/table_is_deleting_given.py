"""Given: the "s3 tables" "table" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given('the "s3 tables" "table" was "DELETING"')
def table_is_deleting_given(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).setup_bucket_namespace_table()
    lws_session.lifecycle("s3tables").delete_dwell_ms(5000).apply()
    lws_session.client("s3tables").delete_table(
        tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE, name=TEST_TABLE
    )
