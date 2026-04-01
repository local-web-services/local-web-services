"""Given: sid in secret_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given("sid in secret_status")
def secretsmanager_events_sid_in_secret_status(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_secret()
