"""Given: the "documentdb" "cluster" was "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "documentdb" "cluster" was "MODIFYING"')
def cluster_is_modifying_given(lws_session):
    lws_session.inject_state("docdb", "cluster", TEST_CLUSTER, "modifying")
