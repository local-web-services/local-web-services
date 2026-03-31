"""Given: a "glacier" "vault" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsGlacierTestClient


@given('a "glacier" "vault" is created')
def glacier_vault_has_been_created(lws_session):
    StepfunctionsGlacierTestClient(lws_session).create_vault()
