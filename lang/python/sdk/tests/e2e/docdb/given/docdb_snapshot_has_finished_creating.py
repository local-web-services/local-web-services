"""Given: a "documentdb" "cluster" documentdb snapshot finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "documentdb" "cluster" documentdb snapshot finishes creating')
def docdb_snapshot_has_finished_creating(lws_session):
    # Arrange / Act
    lws_session.inject_state("docdb", "snapshot", TEST_SNAPSHOT, "available")
    # Assert
    pass
