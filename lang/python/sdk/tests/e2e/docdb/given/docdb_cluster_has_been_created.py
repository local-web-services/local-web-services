"""Given: a database cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("a database cluster has been created")
def docdb_cluster_has_been_created(lws_session):
    DocdbTestClient(lws_session).create_cluster()
