"""When: a policy is attached to a table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET, TEST_NAMESPACE, TEST_TABLE


@when("a policy is attached to a table")
def put_table_policy(lws_session, world):
    try:
        resp = S3tablesTestClient(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = S3tablesTestClient(lws_session).put_table_policy(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            resourcePolicy='{"Version":"2012-10-17","Statement":[]}',
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
