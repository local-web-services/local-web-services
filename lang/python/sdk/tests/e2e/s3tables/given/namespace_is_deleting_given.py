"""Given: the "s3 tables" "namespace" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE


@given('the "s3 tables" "namespace" was "DELETING"')
def namespace_is_deleting_given(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).setup_bucket_and_namespace()
    lws_session.lifecycle("s3tables").delete_dwell_ms(5000).apply()
    lws_session.client("s3tables").delete_namespace(
        tableBucketARN=bucket_arn, namespace=TEST_NAMESPACE
    )
