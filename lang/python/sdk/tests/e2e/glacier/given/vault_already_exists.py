"""Given: the "glacier" "vault" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient


@given('the "glacier" "vault" already existed')
def vault_already_exists(lws_session):
    GlacierTestClient(lws_session).create_vault()
