"""When: a "s3 tables" "bucket" finishes being deleted"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_BUCKET


@when('a "s3 tables" "bucket" finishes being deleted')
def table_bucket_finishes_deleting(lws_session, world):
    try:
        lws_session.inject_state_unchecked("s3tables", "bucket", TEST_BUCKET, "deleted")
    except RuntimeError as exc:
        world["error"] = exc
