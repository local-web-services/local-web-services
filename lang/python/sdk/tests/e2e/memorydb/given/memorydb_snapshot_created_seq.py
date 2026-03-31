"""Given: a "memorydb" "snapshot" is created from an available "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('a "memorydb" "snapshot" is created from an available "memorydb" "cluster"')
def memorydb_snapshot_created_seq(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
    MemorydbTestClient(lws_session).create_snapshot()
