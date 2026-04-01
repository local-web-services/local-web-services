"""Given: a "memorydb" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "memorydb" "cluster" deletion completes')
def memorydb_cluster_deletion_completed_seq(lws_session):
    lws_session.inject_state("memorydb", "cluster", TEST_CLUSTER, "deleted")
