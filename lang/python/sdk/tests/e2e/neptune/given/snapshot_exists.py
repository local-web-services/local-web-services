"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("the snapshot exists")
def snapshot_exists(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
