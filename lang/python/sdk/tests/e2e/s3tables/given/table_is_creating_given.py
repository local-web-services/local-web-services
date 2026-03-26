"""Given: the table is "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@given('the table is "CREATING"')
def table_is_creating_given(lws_session):
    try:
        bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
        S3tablesTestClient(lws_session).delete_table(
            tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE, name=TEST_TABLE
        )
    except Exception:
        pass
    lws_session.lifecycle("s3tables").create_dwell_ms(5000).apply()
    S3tablesTestClient(lws_session).setup_bucket_namespace_table()
