"""Given: busid in bus_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given("busid in bus_status")
def secretsmanager_events_busid_in_bus_status(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_bus()
