"""Given: a database cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a database cluster has been created")
def neptune_database_cluster_created_seq(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
