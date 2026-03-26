"""Given: a database cluster has finished creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("a database cluster has finished creating")
def docdb_cluster_has_finished_creating(lws_session):
    DocdbTestClient(lws_session).create_cluster()
