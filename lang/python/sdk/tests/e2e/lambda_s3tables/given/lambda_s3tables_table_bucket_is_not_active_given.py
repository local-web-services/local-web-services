"""Given: the "s3 tables" "bucket" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient
from ..constants import _table_bucket_arn


@given('the "s3 tables" "bucket" was not "ACTIVE"')
def lambda_s3tables_table_bucket_is_not_active_given(lws_session, world):
    try:
        lws_session.client("s3tables").delete_table_bucket(tableBucketARN=_table_bucket_arn())
    except Exception:
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    LambdaS3tablesTestClient(lws_session).create_table_bucket()
    world["result"] = None
    world["error"] = None
