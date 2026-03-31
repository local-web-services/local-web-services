"""Given: the "documentdb" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbTestClient


@given('the "documentdb" "snapshot" existed')
def snapshot_exists(lws_session):
    DocdbTestClient(lws_session).create_cluster()
    DocdbTestClient(lws_session).create_snapshot()
