"""Given: the secret already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerEventsTestClient


@given("the secret already exists")
def secret_already_exists(lws_session):
    SecretsmanagerEventsTestClient(lws_session).create_secret()
