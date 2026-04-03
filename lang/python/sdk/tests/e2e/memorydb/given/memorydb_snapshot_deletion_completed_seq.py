"""Given: a "memorydb" "snapshot" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "memorydb" "snapshot" deletion completes')
def memorydb_snapshot_deletion_completed_seq(lws_session):
    lws_session.inject_state("memorydb", "snapshot", TEST_SNAPSHOT, "deleted")
