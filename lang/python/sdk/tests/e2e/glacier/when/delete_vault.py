"""When: an empty vault is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import GlacierTestClient
from ..constants import TEST_VAULT


@when("an empty vault is deleted")
def delete_vault(lws_session, world):
    try:
        world["result"] = GlacierTestClient(lws_session).delete_vault(
            accountId="-", vaultName=TEST_VAULT
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
