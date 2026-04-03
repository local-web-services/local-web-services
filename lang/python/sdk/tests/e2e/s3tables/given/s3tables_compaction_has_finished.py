"""Given: compaction finishes on a "s3 tables" "table" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_TABLE


@given('compaction finishes on a "s3 tables" "table"')
def s3tables_compaction_has_finished(lws_session):
    lws_session.inject_state("s3tables", "table", TEST_TABLE, "active")
