"""Given: a database instance configuration has been modified"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a database instance configuration has been modified")
def neptune_database_instance_configuration_modified_seq(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_instance()
