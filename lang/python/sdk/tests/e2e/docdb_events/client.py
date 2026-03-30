"""Test client for docdb_events tests."""

from __future__ import annotations

import pytest

from .constants import TEST_BUS, TEST_CLUSTER


class DocdbEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _docdb = lws_session.client("docdb")
        self._docdb = _docdb
        _events = lws_session.client("events")
        self._events = _events

    def create_cluster(self, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._docdb.create_db_cluster(
            DBClusterIdentifier=cluster_id,
            Engine="docdb",
            MasterUsername="admin",
            MasterUserPassword="e2e-test-password-1",
        )

    def create_bus(self, name=TEST_BUS):
        try:
            self._events.create_event_bus(Name=name)
        except Exception:
            pass
