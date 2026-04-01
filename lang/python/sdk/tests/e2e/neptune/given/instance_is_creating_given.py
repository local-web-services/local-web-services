"""Given: the "neptune" "instance" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_CLUSTER, TEST_INSTANCE


@given('the "neptune" "instance" was "CREATING"')
def instance_is_creating_given(lws_session):
    try:
        lws_session.client("neptune").delete_db_instance(DBInstanceIdentifier=TEST_INSTANCE)
    except Exception:
        pass
    NeptuneTestClient(lws_session).create_cluster()
    lws_session.lifecycle("neptune").create_dwell_ms(5000).apply()
    lws_session.client("neptune").create_db_instance(
        DBInstanceIdentifier=TEST_INSTANCE,
        DBInstanceClass="db.t3.medium",
        Engine="neptune",
        DBClusterIdentifier=TEST_CLUSTER,
    )
