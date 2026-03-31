"""When: a "neptune" "cluster" neptune snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SNAPSHOT


@when('a "neptune" "cluster" neptune snapshot deletion completes')
def snapshot_deletion_completes(lws_session, world):
    lws_session.inject_state("neptune", "snapshot", TEST_SNAPSHOT, "deleted")
