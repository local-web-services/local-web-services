"""Given: the "elasticache" "cluster" was "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_CLUSTER


@given('the "elasticache" "cluster" was "MODIFYING"')
def cluster_is_modifying_given(lws_session, world):
    # Arrange
    cluster_id = world.get("cluster_id", TEST_CLUSTER)
    # Act
    lws_session.inject_state("elasticache", "cluster", cluster_id, "modifying")
    # Assert
    world["cluster_state"] = "modifying"
