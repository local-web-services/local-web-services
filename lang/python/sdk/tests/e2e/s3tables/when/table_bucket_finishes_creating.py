"""When: a "s3 tables" "bucket" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_BUCKET


@when('a "s3 tables" "bucket" finishes creating')
def table_bucket_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state("s3tables", "bucket", TEST_BUCKET, "active")
    except RuntimeError as exc:
        world["error"] = exc
