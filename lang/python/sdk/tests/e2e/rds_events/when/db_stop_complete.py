"""When: the "rds" "DB instance" finishes stopping"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DB_INSTANCE


@when('the "rds" "DB instance" finishes stopping')
def db_stop_complete(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "rds",
            "instance",
            world.get("instance_id", TEST_DB_INSTANCE),
            "stopped",
        )
    except RuntimeError as exc:
        world["error"] = exc
