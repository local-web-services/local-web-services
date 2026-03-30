"""
Given: a secret has been scheduled for deletion and Secrets Manager has delivered a "DELETED"
event to the bus
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient
from ..constants import TEST_SECRET


@given(
    'a secret has been scheduled for deletion and Secrets Manager has delivered a "DELETED" event to the bus'  # noqa: E501
)
def secretsmanager_events_secret_deleted_event_delivered(lws_session):
    try:
        SecretsmanagerEventsTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerEventsTestClient(lws_session)._sm.delete_secret(SecretId=TEST_SECRET)
