"""When: a table is created in the table bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaS3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE, _table_bucket_arn


@when("a table is created in the table bucket")
def lambda_s3tables_create_table(lws_session, world):
    try:
        if not LambdaS3tablesTestClient(lws_session).table_bucket_exists():
            LambdaS3tablesTestClient(lws_session).create_table_bucket()
        LambdaS3tablesTestClient(lws_session).create_namespace()
        resp = LambdaS3tablesTestClient(lws_session)._s3tables.create_table(
            tableBucketARN=_table_bucket_arn(),
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            format="ICEBERG",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
