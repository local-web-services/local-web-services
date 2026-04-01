"""Given: a policy is attached to a "s3 tables" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given('a policy is attached to a "s3 tables" "table"')
def s3tables_a_policy_has_been_attached(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).setup_bucket_namespace_table()
    S3tablesTestClient(lws_session).put_table_policy(
        tableBucketARN=bucket_arn,
        namespace=TEST_NAMESPACE,
        name=TEST_TABLE,
        resourcePolicy='{"Version":"2012-10-17","Statement":[]}',
    )
