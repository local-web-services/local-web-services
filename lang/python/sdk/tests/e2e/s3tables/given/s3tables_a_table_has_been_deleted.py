"""Given: a table has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given("a table has been deleted")
def s3tables_a_table_has_been_deleted(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).setup_bucket_namespace_table()
    S3tablesTestClient(lws_session).delete_table(
        tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE, name=TEST_TABLE
    )
