"""Given: a "s3 tables" "namespace" finishes being deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE


@given('a "s3 tables" "namespace" finishes being deleted')
def s3tables_a_namespace_has_finished_being_deleted(lws_session):
    bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
    ns_key = f"{bucket_arn}#{TEST_NAMESPACE}"
    lws_session.inject_state("s3tables", "namespace", ns_key, "deleted")
