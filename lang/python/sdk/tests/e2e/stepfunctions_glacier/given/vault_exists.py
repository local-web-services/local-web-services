"""Given: the "glacier" "vault" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsGlacierTestClient


@given('the "glacier" "vault" existed')
def vault_exists(lws_session):
    StepfunctionsGlacierTestClient(lws_session).create_vault()
