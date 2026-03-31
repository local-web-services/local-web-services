"""Given: a replica creation in a "elasticache" "replication group" completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_REPLICATION_GROUP


@given('a replica creation in a "elasticache" "replication group" completes')
def elasticache_replica_creation_completed(lws_session):
    lws_session.inject_state(
        "elasticache", "replication-group", TEST_REPLICATION_GROUP, "available"
    )
