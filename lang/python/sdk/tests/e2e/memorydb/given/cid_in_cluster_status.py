"""Given: cid in cluster_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import MemorydbTestClient


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    MemorydbTestClient(lws_session).create_cluster()
