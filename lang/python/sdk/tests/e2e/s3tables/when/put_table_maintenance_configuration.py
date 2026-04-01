"""When: maintenance configuration is applied to a "s3 tables" "table" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_NAMESPACE, TEST_TABLE


@when('maintenance configuration is applied to a "s3 tables" "table"')
def put_table_maintenance_configuration(lws_session, world):
    try:
        resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
        actual_arn = resp.get("arn", TEST_BUCKET)
        world["result"] = lws_session.client("s3tables").put_table_maintenance_configuration(
            tableBucketARN=actual_arn,
            namespace=TEST_NAMESPACE,
            name=TEST_TABLE,
            type="icebergCompaction",
            value={"status": "enabled"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
