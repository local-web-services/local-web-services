"""When: a "neptune" "instance" finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_INSTANCE


@when('a "neptune" "instance" finishes creating')
def instance_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "available")
    except RuntimeError as exc:
        world["error"] = exc
