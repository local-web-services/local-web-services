"""Given: the vault exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierSnsTestClient


@given("the vault exists")
def vault_exists(lws_session):
    GlacierSnsTestClient(lws_session).create_vault()
