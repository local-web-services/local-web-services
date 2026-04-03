"""Given: a "rds" "snapshot" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "rds" "snapshot" deletion completes')
def a_database_snapshot_deletion_has_completed(lws_session):
    lws_session.inject_state("rds", "snapshot", TEST_SNAPSHOT, "deleted")
