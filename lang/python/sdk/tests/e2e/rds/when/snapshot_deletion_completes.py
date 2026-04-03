"""When: a "rds" "snapshot" deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "rds" "snapshot" deletion completes')
def snapshot_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state(
            "rds",
            "snapshot",
            world.get("snapshot_id", TEST_SNAPSHOT),
            "deleted",
        )
    except RuntimeError as exc:
        world["error"] = exc
