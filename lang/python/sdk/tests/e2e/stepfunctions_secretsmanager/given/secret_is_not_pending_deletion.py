"""Given: the "secretsmanager" "secret" is not pending deletion"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given('the "secretsmanager" "secret" is not pending deletion')
@given('the "secrets manager" "secret" was not "PENDING_DELETION"')
def secret_is_not_pending_deletion(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_secret()
