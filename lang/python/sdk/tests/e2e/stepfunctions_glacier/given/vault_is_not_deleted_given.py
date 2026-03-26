"""Given: the vault is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsGlacierTestClient


@given('the vault is not "DELETED"')
def vault_is_not_deleted_given(lws_session):
    StepfunctionsGlacierTestClient(lws_session).create_vault()
