"""When: a "neptune" "cluster" neptune snapshot finishes creating"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "neptune" "cluster" neptune snapshot finishes creating')
def snapshot_finishes_creating(lws_session, world):
    try:
        lws_session.inject_state_unchecked("neptune", "snapshot", TEST_SNAPSHOT, "available")
    except RuntimeError as exc:
        world["error"] = exc
