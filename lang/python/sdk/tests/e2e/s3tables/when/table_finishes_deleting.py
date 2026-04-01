"""When: a "s3 tables" "table" finishes being deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..client import S3tablesTestClient
from ..constants import TEST_NAMESPACE, TEST_TABLE


@when('a "s3 tables" "table" finishes being deleted')
def table_finishes_deleting(lws_session, world):
    try:
        bucket_arn = S3tablesTestClient(lws_session).get_bucket_arn()
        table_key = f"{bucket_arn}/table/{TEST_NAMESPACE}/{TEST_TABLE}"
        lws_session.inject_state("s3tables", "table", table_key, "deleted")
    except Exception as exc:
        world["error"] = exc
