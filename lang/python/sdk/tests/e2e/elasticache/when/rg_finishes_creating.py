"""When: a "elasticache" "replication group" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_REPLICATION_GROUP


@when('a "elasticache" "replication group" finishes creating')
def rg_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "elasticache", "replication-group", TEST_REPLICATION_GROUP, "available"
        )
    except RuntimeError as exc:
        world["error"] = exc
