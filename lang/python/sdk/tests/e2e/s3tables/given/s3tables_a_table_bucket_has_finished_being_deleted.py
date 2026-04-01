"""Given: a "s3 tables" "table" s3 tables bucket finishes being deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_BUCKET


@given('a "s3 tables" "table" s3 tables bucket finishes being deleted')
def s3tables_a_table_bucket_has_finished_being_deleted(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn(TEST_BUCKET)
    lws_session.inject_state("s3tables", "bucket", bucket_arn, "deleted")
