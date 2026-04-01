"""Given: an "elasticache" "cluster" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('an "elasticache" "cluster" deletion completes')
def elasticache_cluster_deletion_completed(lws_session):
    lws_session.inject_state("elasticache", "cluster", TEST_CLUSTER, "deleted")
