"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("the snapshot exists")
def snapshot_exists(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
    MemorydbTestClient(lws_session).create_snapshot()
