"""When: a "neptune" "instance" modification completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "neptune" "instance" modification completes')
def instance_modification_completes(lws_session, world):
    try:
        lws_session.inject_state(
            "neptune",
            "instance",
            world.get("instance_id", TEST_INSTANCE),
            "available",
        )
    except RuntimeError as exc:
        world["error"] = exc
