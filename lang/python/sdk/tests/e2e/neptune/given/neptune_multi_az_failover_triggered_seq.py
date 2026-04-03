"""Given: a multi-"AZ" failover is triggered on a "neptune" "cluster" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('a multi-"AZ" failover is triggered on a "neptune" "cluster"')
def neptune_multi_az_failover_triggered_seq(lws_session):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
