"""Given: the secrets manager secret existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given("the secrets manager secret existed")
def secret_already_exists(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_secret()
