"""Given: the bus already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given('the "secretsmanager" "secret" already existed')
def secret_already_exists(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_secret()
