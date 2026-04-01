"""Given: a "documentdb" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a "documentdb" "cluster" deletion completes')
def docdb_cluster_deletion_completed(lws_session):
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "deleted")
