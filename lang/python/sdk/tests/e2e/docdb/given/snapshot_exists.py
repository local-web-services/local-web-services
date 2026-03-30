"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given("the snapshot exists")
def snapshot_exists(lws_session):
    DocdbTestClient(lws_session).create_cluster()
    DocdbTestClient(lws_session).create_snapshot()
