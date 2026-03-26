"""Given: tid in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE, _table_bucket_arn


@given("tid in table_status")
def lambda_s3tables_tid_in_table_status(lws_session):
    try:
        LambdaS3tablesTestClient(lws_session).create_table_bucket()
    except Exception:
        pass
    LambdaS3tablesTestClient(lws_session).create_namespace()
    try:
        LambdaS3tablesTestClient(lws_session)._s3tables.create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
    except Exception:
        pass
