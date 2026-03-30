"""Given: a Glacier vault has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaGlacierTestClient
from ..constants import TEST_VAULT


@given("a Glacier vault has been deleted")
def glacier_vault_has_been_deleted_seq(lws_session):
    try:
        LambdaGlacierTestClient(lws_session).create_vault()
    except Exception:
        pass
    LambdaGlacierTestClient(lws_session)._glacier.delete_vault(accountId="-", vaultName=TEST_VAULT)
