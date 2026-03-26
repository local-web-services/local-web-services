"""Given: the vault already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given("the vault already exists")
def vault_already_exists(lws_session):
    GlacierTestClient(lws_session).create_vault()
