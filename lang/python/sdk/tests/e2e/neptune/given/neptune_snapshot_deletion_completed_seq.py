"""Given: a "neptune" "cluster" neptune snapshot deletion completes"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "neptune" "cluster" neptune snapshot deletion completes')
def neptune_snapshot_deletion_completed_seq(lws_session):
    lws_session.inject_state("neptune", "snapshot", TEST_SNAPSHOT, "deleted")
