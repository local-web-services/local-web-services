"""Given: the "neptune" "cluster" was "STOPPED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" was "STOPPED"')
def cluster_is_stopped_given(lws_session):
    # Arrange
    NeptuneTestClient(lws_session).delete_cluster()
    lws_session.lifecycle("neptune").create_dwell_ms(0).apply()
    NeptuneTestClient(lws_session).create_cluster()
    # Act
    NeptuneTestClient(lws_session).stop_cluster()
    # Assert
    pass
