"""Given: a database instance has been created in an available cluster"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a database instance has been created in an available cluster")
def neptune_database_instance_created_seq(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_instance()
