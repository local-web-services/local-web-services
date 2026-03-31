"""Given: a "documentdb" "cluster" documentdb snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "documentdb" "cluster" documentdb snapshot deletion completes')
def docdb_snapshot_deletion_completed(lws_session):
    # Arrange / Act
    lws_session.inject_state("docdb", "snapshot", TEST_SNAPSHOT, "deleted")
    # Assert
    pass
