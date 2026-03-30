"""Given: the vault is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaGlacierTestClient
from ..constants import TEST_VAULT


@given('the vault is already "DELETED"')
def vault_is_already_deleted(lws_session, world):
    try:
        LambdaGlacierTestClient(lws_session).create_vault()
    except Exception:
        pass
    lws_session.lifecycle("glacier").delete_dwell_ms(5000).apply()
    try:
        LambdaGlacierTestClient(lws_session)._glacier.delete_vault(
            accountId="-", vaultName=TEST_VAULT
        )
    except Exception:
        pass
    world["result"] = None
    world["error"] = None
