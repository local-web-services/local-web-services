"""Given: the replication group is "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_REPLICATION_GROUP


@given('the replication group is "MODIFYING"')
def rg_is_modifying_given(lws_session, world):
    # Arrange
    rg_id = world.get("replication_group_id", TEST_REPLICATION_GROUP)
    # Act
    lws_session.inject_state("elasticache", "replication_group", rg_id, "modifying")
    # Assert
    world["replication_group_state"] = "modifying"
