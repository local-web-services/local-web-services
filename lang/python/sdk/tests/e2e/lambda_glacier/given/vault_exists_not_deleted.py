"""Given: the vault "EXISTS" (not already "DELETED")"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaGlacierTestClient


@given('the vault "EXISTS" (not already "DELETED")')
def vault_exists_not_deleted(lws_session):
    try:
        LambdaGlacierTestClient(lws_session).create_vault()
    except Exception:
        pass
