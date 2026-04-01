"""Given: a database instance has been rebooted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER, TEST_INSTANCE


@given("a database instance has been rebooted")
def neptune_database_instance_rebooted_seq(lws_session):
    # Arrange
    NeptuneTestClient(lws_session).create_cluster()
    lws_session.inject_state("neptune", "cluster", TEST_CLUSTER, "available")
    NeptuneTestClient(lws_session).create_instance()
    lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "available")
    # Act
    NeptuneTestClient(lws_session).reboot_instance()
    lws_session.inject_state("neptune", "instance", TEST_INSTANCE, "rebooting")
    # Assert
    pass
