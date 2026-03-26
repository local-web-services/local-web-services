"""Given: the secret is not pending deletion"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient


@given("the secret is not pending deletion")
def secret_is_not_pending_deletion(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_secret()
