"""Given: sid in snapshot_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("sid in snapshot_status")
def sid_in_snapshot_status(lws_session):
    DocdbTestClient(lws_session).create_cluster()
    DocdbTestClient(lws_session).create_snapshot()
