"""Given: the "documentdb" "cluster" modification completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "documentdb" "cluster" modification completes')
def docdb_events_cluster_modification_completed(lws_session):
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "available")
