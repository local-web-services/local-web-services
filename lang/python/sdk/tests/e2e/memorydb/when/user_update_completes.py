"""When: a "memorydb" "user" update completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_USER


@when('a "memorydb" "user" update completes')
def user_update_completes(lws_session, world):
    try:
        lws_session.inject_state(
            "memorydb",
            "user",
            world.get("user_id", TEST_USER),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
