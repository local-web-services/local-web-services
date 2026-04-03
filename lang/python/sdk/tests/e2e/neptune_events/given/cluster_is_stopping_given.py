"""Given: the "neptune" "cluster" was "STOPPING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "neptune" "cluster" was "STOPPING"')
def cluster_is_stopping_given(lws_session):
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "stopping")
