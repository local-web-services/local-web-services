"""When: a "documentdb" "cluster" documentdb snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "documentdb" "cluster" documentdb snapshot deletion completes')
def snapshot_deletion_completes(lws_session, world):
    # Arrange / Act
    lws_session.inject_state("docdb", "snapshot", TEST_SNAPSHOT, "deleted")
    # Assert
    pass
