"""Given: sid in snapshot_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("sid in snapshot_status")
def sid_in_snapshot_status(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
    MemorydbTestClient(lws_session).create_snapshot()
