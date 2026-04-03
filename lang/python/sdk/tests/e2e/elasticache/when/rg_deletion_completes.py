"""When: a "elasticache" "replication group" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_REPLICATION_GROUP


@when('a "elasticache" "replication group" deletion completes')
def rg_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "elasticache", "replication-group", TEST_REPLICATION_GROUP, "deleted"
        )
    except RuntimeError as exc:
        world["error"] = exc
