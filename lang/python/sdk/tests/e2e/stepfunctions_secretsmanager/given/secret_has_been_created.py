"""Given: a "secretsmanager" "secret" is created in Secrets Manager"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given('a "secretsmanager" "secret" is created in Secrets Manager')
def secret_has_been_created(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_secret()
