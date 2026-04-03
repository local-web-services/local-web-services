"""When: a "rds" "instance" reboot completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_DB


@when('a "rds" "instance" reboot completes')
def instance_reboot_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "rds",
            "instance",
            world.get("instance_id", TEST_DB),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
