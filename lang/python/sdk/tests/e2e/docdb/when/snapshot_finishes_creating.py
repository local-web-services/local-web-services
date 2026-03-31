"""When: a "documentdb" "cluster" documentdb snapshot finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "documentdb" "cluster" documentdb snapshot finishes creating')
def snapshot_finishes_creating(lws_session, world):
    # Arrange / Act
    lws_session.inject_state("docdb", "snapshot", TEST_SNAPSHOT, "available")
    # Assert
    pass
