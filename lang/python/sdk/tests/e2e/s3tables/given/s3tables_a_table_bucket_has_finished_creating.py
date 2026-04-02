"""Given: a "s3 tables" "bucket" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_BUCKET


@given('a "s3 tables" "bucket" finishes creating')
def s3tables_a_table_bucket_has_finished_creating(lws_session):
    lws_session.inject_state("s3tables", "bucket", TEST_BUCKET, "active")
