"""Given: the "elasticache" "cluster" modification completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "elasticache" "cluster" modification completes')
def elasticache_sns_cluster_modification_completed(lws_session):
    lws_session.inject_state("elasticache", "cluster", TEST_CLUSTER, "available")
