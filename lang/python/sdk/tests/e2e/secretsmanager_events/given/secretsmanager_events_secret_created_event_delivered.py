"""
Given: a secret has been created and Secrets Manager has delivered a "CREATED" event to the
EventBridge bus
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given(
    'a secret has been created and Secrets Manager has delivered a "CREATED" event to the EventBridge bus'  # noqa: E501
)
def secretsmanager_events_secret_created_event_delivered(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_secret()
