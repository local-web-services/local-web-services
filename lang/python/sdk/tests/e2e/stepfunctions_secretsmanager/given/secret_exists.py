"""Given: the "secretsmanager" "secret" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given('the "secretsmanager" "secret" already existed')
def secret_exists(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_secret()
