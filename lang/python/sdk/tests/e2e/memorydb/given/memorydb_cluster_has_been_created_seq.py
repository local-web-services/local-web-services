"""Given: a "memorydb" "cluster" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('a "memorydb" "cluster" is created')
def memorydb_cluster_has_been_created_seq(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
