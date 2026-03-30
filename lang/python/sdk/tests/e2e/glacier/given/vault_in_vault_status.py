"""Given: vault in vault_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given("vault in vault_status")
def vault_in_vault_status(lws_session):
    GlacierTestClient(lws_session).create_vault()
