"""Given: a MemoryDB cluster has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaMemorydbTestClient


@given("a MemoryDB cluster has been created")
def memorydb_cluster_has_been_created_seq(lws_session):
    LambdaMemorydbTestClient(lws_session).create_cluster()
