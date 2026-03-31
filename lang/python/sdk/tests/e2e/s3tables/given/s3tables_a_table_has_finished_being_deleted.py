"""Given: a "s3 tables" "table" finishes being deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given('a "s3 tables" "table" finishes being deleted')
def s3tables_a_table_has_finished_being_deleted(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
    table_key = f"{bucket_arn}/table/{TEST_NAMESPACE}/{TEST_TABLE}"
    lws_session.inject_state("s3tables", "table", table_key, "deleted")
