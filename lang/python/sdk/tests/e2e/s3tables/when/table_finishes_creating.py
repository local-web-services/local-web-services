"""When: a "s3 tables" "table" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@when('a "s3 tables" "table" finishes creating')
def table_finishes_creating(lws_session, world):
    bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
    table_key = f"{bucket_arn}/table/{TEST_NAMESPACE}/{TEST_TABLE}"
    try:
        lws_session.inject_state("s3tables", "table", table_key, "active")
    except RuntimeError as exc:
        world["error"] = exc
