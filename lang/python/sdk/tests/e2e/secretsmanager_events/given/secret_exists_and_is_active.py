"""Given: the secret exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given('the secret exists and is "ACTIVE"')
def secret_exists_and_is_active(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_secret()
