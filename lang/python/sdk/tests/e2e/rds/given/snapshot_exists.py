"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import RdsTestClient


@given("the snapshot exists")
def snapshot_exists(lws_session):
    RdsTestClient(lws_session).create_db_instance()
    RdsTestClient(lws_session).create_snapshot()
