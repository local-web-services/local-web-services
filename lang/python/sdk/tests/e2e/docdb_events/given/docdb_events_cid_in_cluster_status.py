"""Given: cid in cluster_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import DocdbEventsTestClient


@given("cid in cluster_status")
def docdb_events_cid_in_cluster_status(lws_session):
    DocdbEventsTestClient(lws_session).create_cluster()
