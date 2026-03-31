"""When: a table deletion is initiated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_NAMESPACE, TEST_TABLE, _table_bucket_arn


@when("a table deletion is initiated")
def lambda_s3tables_initiate_table_deletion(lws_session, world):
    try:
        world["result"] = lws_session.client("s3tables").delete_table(
            tableBucketARN=_table_bucket_arn(), namespace=TEST_NAMESPACE, name=TEST_TABLE
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
