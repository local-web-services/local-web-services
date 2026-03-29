"""Given: a database cluster snapshot has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import NeptuneTestClient


@given("a database cluster snapshot has been created")
def neptune_snapshot_created_seq(lws_session):
    NeptuneTestClient(lws_session).create_cluster()
    NeptuneTestClient(lws_session).create_snapshot()
