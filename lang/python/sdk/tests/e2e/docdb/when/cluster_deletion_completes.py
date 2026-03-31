"""When: a "documentdb" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_CLUSTER


@when('a "documentdb" "cluster" deletion completes')
def cluster_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "deleted")
    except RuntimeError as exc:
        world["error"] = exc
