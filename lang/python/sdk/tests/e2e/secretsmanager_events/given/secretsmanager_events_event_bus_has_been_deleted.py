"""Given: the "eventbridge" "bus" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient
from ..constants import TEST_BUS


@given('the "eventbridge" "bus" is deleted')
def secretsmanager_events_event_bus_has_been_deleted(lws_session):
    try:
        SecretsmanagerEventsTestClient(lws_session).create_bus()
    except Exception:
        pass
    SecretsmanagerEventsTestClient(lws_session)._events.delete_event_bus(Name=TEST_BUS)
