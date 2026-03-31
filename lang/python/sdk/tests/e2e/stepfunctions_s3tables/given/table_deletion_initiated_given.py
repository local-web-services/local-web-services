"""Given: a table deletion is initiated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient
from ..constants import TEST_BUCKET


@given("a table deletion is initiated")
def table_deletion_initiated_given(lws_session):
    try:
        StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
    except Exception:
        pass
    resp = lws_session.client("s3tables").get_table_bucket(tableBucketARN=TEST_BUCKET)
    actual_arn = resp.get("arn", TEST_BUCKET)
    lws_session.client("s3tables").delete_table_bucket(tableBucketARN=actual_arn)
