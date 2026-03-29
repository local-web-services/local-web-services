"""Given: a namespace has been deleted from a table bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE


@given("a namespace has been deleted from a table bucket")
def s3tables_a_namespace_has_been_deleted(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).setup_bucket_and_namespace()
    try:
        S3tablesTestClient(lws_session).delete_namespace(
            tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE
        )
    except Exception:
        pass
