"""Test client for neptune_events tests."""

from __future__ import annotations

import pytest

from .constants import TEST_BUS, TEST_CLUSTER


class NeptuneEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _neptune = lws_session.client("neptune")
        self._neptune = _neptune
        _events = lws_session.client("events")
        self._events = _events

    def create_cluster(self, cluster_id=TEST_CLUSTER):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._neptune.create_db_cluster(DBClusterIdentifier=cluster_id, Engine="neptune")

    def create_bus(self, name=TEST_BUS):
        self._events.create_event_bus(Name=name)
