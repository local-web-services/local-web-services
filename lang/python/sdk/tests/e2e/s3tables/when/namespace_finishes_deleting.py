"""When: a "s3 tables" "namespace" finishes being deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE


@when('a "s3 tables" "namespace" finishes being deleted')
def namespace_finishes_deleting(lws_session, world):
    try:
        bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
        ns_key = f"{bucket_arn}#{TEST_NAMESPACE}"
        lws_session.inject_state("s3tables", "namespace", ns_key, "deleted")
    except Exception as exc:
        world["error"] = exc
