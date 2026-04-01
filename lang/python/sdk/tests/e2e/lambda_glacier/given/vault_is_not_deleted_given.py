"""Given: the "glacier" "vault" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaGlacierTestClient


@given('the "glacier" "vault" was not "DELETED"')
def vault_is_not_deleted_given(lws_session):
    LambdaGlacierTestClient(lws_session).create_vault()
