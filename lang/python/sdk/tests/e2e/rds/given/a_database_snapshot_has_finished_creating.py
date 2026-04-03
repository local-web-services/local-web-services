"""Given: a "rds" "snapshot" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "rds" "snapshot" finishes creating')
def a_database_snapshot_has_finished_creating(lws_session):
    lws_session.inject_state("rds", "snapshot", TEST_SNAPSHOT, "available")
