"""Given: a "documentdb" "cluster" finishes creating"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('a "documentdb" "cluster" finishes creating')
def docdb_cluster_has_finished_creating(lws_session):
    DocdbTestClient(lws_session).create_cluster()
