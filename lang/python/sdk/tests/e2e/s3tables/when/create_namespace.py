"""When: a namespace is created in a table bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET, TEST_NAMESPACE


@when("a namespace is created in a table bucket")
def create_namespace(lws_session, world):
    try:
        resp = S3tablesTestClient(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = S3tablesTestClient(lws_session).create_namespace(
            tableBucketARN=actual_arn, namespace=[TEST_NAMESPACE]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
