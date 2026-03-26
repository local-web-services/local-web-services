"""Given: the vault "EXISTS" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaGlacierTestClient


@given('the vault "EXISTS"')
def vault_exists_quoted(lws_session):
    LambdaGlacierTestClient(lws_session).create_vault()
