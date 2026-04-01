"""When: a table deletion is initiated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET


@when("a table deletion is initiated")
def initiate_table_deletion(lws_session, world):
    try:
        resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = lws_session.client("s3tables").delete_table_bucket(
            tableBucketARN=actual_arn
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
