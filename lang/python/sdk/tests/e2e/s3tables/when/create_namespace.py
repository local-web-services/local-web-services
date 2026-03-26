"""When: a namespace is created in a table bucket"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_NAMESPACE


@when("a namespace is created in a table bucket")
def create_namespace(lws_session, world):
    try:
        resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = lws_session.client("s3tables").create_namespace(
            tableBucketARN=actual_arn, namespace=[TEST_NAMESPACE]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
