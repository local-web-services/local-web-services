"""Given: a table's policy has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given("a table's policy has been deleted")
def s3tables_a_tables_policy_has_been_deleted(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).setup_bucket_namespace_table()
    S3tablesTestClient(lws_session).put_table_policy(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
        resourcePolicy='{"Version":"2012-10-17","Statement":[]}',
    )
    S3tablesTestClient(lws_session).delete_table_policy(
        tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE, name=TEST_TABLE
    )
