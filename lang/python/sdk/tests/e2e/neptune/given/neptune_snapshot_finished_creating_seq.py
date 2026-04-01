"""Given: a "neptune" "cluster" neptune snapshot finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_SNAPSHOT


@given('a "neptune" "cluster" neptune snapshot finishes creating')
def neptune_snapshot_finished_creating_seq(lws_session):
    lws_session.inject_state("neptune", "snapshot", TEST_SNAPSHOT, "available")
