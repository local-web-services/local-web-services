"""Given: the "neptune" "cluster" was not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER


@given('the "neptune" "cluster" was not "AVAILABLE"')
def cluster_is_not_available_given(lws_session):
    # Arrange
    cluster_id = TEST_CLUSTER
    # Act
    NeptuneTestClient(lws_session).create_cluster(cluster_id)
    lws_session.client("neptune").stop_db_cluster(DBClusterIdentifier=cluster_id)
