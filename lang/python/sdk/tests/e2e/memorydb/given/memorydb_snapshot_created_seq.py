"""Given: a snapshot has been created from an available cluster"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("a snapshot has been created from an available cluster")
def memorydb_snapshot_created_seq(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
    MemorydbTestClient(lws_session).create_snapshot()
