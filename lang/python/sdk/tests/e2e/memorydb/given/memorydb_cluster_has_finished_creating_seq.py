"""Given: a "memorydb" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "memorydb" "cluster" finishes creating')
def memorydb_cluster_has_finished_creating_seq(lws_session):
    lws_session.inject_state("memorydb", "cluster", TEST_CLUSTER, "available")
