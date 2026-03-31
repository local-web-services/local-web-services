"""Given: the table was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient
from ..constants import TEST_BUCKET


@given('the table was "DELETING"')
def table_is_deleting_given(lws_session, world):
    try:
        StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
    except Exception:
        pass
    resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
    actual_arn = resp.get("arn", TEST_BUCKET)
    lws_session.lifecycle("s3tables").delete_dwell_ms(5000).apply()
    lws_session.client("s3tables").delete_table_bucket(tableBucketARN=actual_arn)
    world["result"] = None
    world["error"] = None
