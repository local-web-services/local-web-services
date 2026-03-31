"""Given: a stopped neptune database neptune cluster is started"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a stopped neptune database neptune cluster is started")
def neptune_stopped_cluster_started_seq(lws_session):
    # Arrange
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).stop_cluster()
    # Act
    NeptuneTestClient(lws_session).start_cluster()
    # Assert
    pass
