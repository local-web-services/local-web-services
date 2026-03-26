"""Test client for rds_events tests."""

from __future__ import annotations

import pytest

from .constants import TEST_BUS, TEST_DB_INSTANCE


class RdsEventsTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        _rds = lws_session.client("rds")
        self._rds = _rds
        _events = lws_session.client("events")
        self._events = _events

    def create_db_instance(self, instance_id=TEST_DB_INSTANCE):
        pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
        self._rds.create_db_instance(
            DBInstanceIdentifier=instance_id,
            DBInstanceClass="db.t3.micro",
            Engine="mysql",
            MasterUsername="admin",
            MasterUserPassword="e2e-test-password-1",
        )

    def create_bus(self, name=TEST_BUS):
        self._events.create_event_bus(Name=name)
