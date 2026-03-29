"""
Given: a secret has been created but the "CREATED" event delivery has failed because the bus is
deleted
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given(
    'a secret has been created but the "CREATED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def secretsmanager_events_secret_created_event_failed(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_secret()
