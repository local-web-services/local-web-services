"""Given: a database cluster has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a database cluster has been deleted")
def neptune_database_cluster_deleted_seq(lws_session):
    try:
        NeptuneTestClient(lws_session).create_cluster()
    except Exception:
        pass
    NeptuneTestClient(lws_session).delete_cluster()
