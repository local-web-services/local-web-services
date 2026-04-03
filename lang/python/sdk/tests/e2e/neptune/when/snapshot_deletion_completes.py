"""When: a "neptune" "cluster" neptune snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "neptune" "cluster" neptune snapshot deletion completes')
def snapshot_deletion_completes(lws_session, world):
    try:
        lws_session.inject_state_unchecked("neptune", "snapshot", TEST_SNAPSHOT, "deleted")
    except RuntimeError as exc:
        world["error"] = exc
