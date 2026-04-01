"""Given: the "neptune" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given('the "neptune" "snapshot" existed')
def snapshot_exists(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
