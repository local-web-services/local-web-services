"""When: a replica creation in a "elasticache" "replication group" completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_REPLICATION_GROUP


@when('a replica creation in a "elasticache" "replication group" completes')
def replica_creation_completes(lws_session, world):
    try:
        lws_session.inject_state(
            "elasticache", "replication-group", TEST_REPLICATION_GROUP, "available"
        )
    except RuntimeError as exc:
        world["error"] = exc
