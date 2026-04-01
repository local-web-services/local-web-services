"""Given: the "neptune" "cluster" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER


@given('the "neptune" "cluster" was "DELETING"')
def cluster_is_deleting_given(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    lws_session.lifecycle("neptune").delete_dwell_ms(5000).apply()
    lws_session.client("neptune").delete_db_cluster(DBClusterIdentifier=TEST_CLUSTER)
