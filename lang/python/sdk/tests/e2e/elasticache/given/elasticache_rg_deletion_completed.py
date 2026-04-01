"""Given: a "elasticache" "replication group" deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_REPLICATION_GROUP


@given('a "elasticache" "replication group" deletion completes')
def elasticache_rg_deletion_completed(lws_session):
    lws_session.inject_state("elasticache", "replication-group", TEST_REPLICATION_GROUP, "deleted")
