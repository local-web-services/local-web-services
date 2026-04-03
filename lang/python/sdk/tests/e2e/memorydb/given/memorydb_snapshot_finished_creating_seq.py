"""Given: a "memorydb" "snapshot" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "memorydb" "snapshot" finishes creating')
def memorydb_snapshot_finished_creating_seq(lws_session):
    lws_session.inject_state("memorydb", "snapshot", TEST_SNAPSHOT, "available")
