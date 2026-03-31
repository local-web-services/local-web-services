"""Given: a database cluster has been stopped"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a database cluster has been stopped")
def neptune_database_cluster_stopped_seq(lws_session):
    # Arrange
    NeptuneTestClient(lws_session).create_cluster()
    # Act
    NeptuneTestClient(lws_session).stop_cluster()
    # Assert
    pass
