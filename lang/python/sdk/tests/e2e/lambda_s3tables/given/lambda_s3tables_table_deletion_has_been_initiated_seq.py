"""Given: a table deletion is initiated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE, _table_bucket_arn


@given("a table deletion is initiated")
def lambda_s3tables_table_deletion_has_been_initiated_seq(lws_session):
    LambdaS3tablesTestClient(lws_session).create_table_bucket()
    LambdaS3tablesTestClient(lws_session).create_namespace()
    try:
        lws_session.client("s3tables").create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
    except Exception:
        pass
    lws_session.client("s3tables").delete_table(
        tableBucketARN=_table_bucket_arn(), namespace=TEST_NAMESPACE, name=TEST_TABLE
    )
