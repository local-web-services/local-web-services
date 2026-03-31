"""Given: the "neptune" "instance" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_INSTANCE


@given('the "neptune" "instance" was "DELETING"')
def instance_is_deleting_given(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_instance()
    lws_session.lifecycle("neptune").delete_dwell_ms(5000).apply()
    lws_session.client("neptune").delete_db_instance(DBInstanceIdentifier=TEST_INSTANCE)
