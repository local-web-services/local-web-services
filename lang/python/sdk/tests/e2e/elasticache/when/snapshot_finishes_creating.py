"""When: an "elasticache" "snapshot" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('an "elasticache" "snapshot" finishes creating')
def snapshot_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "elasticache",
            "snapshot",
            world.get("snapshot_id", TEST_SNAPSHOT),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
