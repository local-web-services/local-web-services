"""Given: sid in snapshot_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("sid in snapshot_status")
def sid_in_snapshot_status(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
