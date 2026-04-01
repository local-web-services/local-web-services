"""Given: a database instance has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient
from ..constants import TEST_INSTANCE


@given("a database instance has been deleted")
def neptune_database_instance_deleted_seq(lws_session):
    try:
        NeptuneTestClient(lws_session).create_cluster()
        NeptuneTestClient(lws_session).create_instance()
    except Exception:
        pass
    NeptuneTestClient(lws_session).delete_db_instance(DBInstanceIdentifier=TEST_INSTANCE)
