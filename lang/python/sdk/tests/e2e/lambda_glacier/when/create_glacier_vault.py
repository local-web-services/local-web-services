"""When: a "glacier" "vault" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaGlacierTestClient
from ..constants import TEST_VAULT


@when('a "glacier" "vault" is created')
def create_glacier_vault(lws_session, world):
    try:
        LambdaGlacierTestClient(lws_session).create_vault()
        world["result"] = {"vaultName": TEST_VAULT}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
