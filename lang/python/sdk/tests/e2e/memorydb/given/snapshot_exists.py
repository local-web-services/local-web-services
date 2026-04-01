"""Given: the "memorydb" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given('the "memorydb" "snapshot" existed')
def snapshot_exists(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
    MemorydbTestClient(lws_session).create_snapshot()
