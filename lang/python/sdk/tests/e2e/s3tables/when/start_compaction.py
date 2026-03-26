"""When: compaction is started on a table"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET


@when("compaction is started on a table")
def start_compaction(lws_session, world):
    try:
        resp = S3tablesTestClient(lws_session).get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = S3tablesTestClient(lws_session).start_table_bucket_maintenance(
            tableBucketARN=actual_arn, type="icebergCompaction", value={"status": "enabled"}
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
