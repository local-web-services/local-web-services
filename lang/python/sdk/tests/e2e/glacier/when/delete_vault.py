"""When: an empty "glacier" "vault" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when('an empty "glacier" "vault" is deleted')
def delete_vault(lws_session, world):
    try:
        world["result"] = lws_session.client("glacier").delete_vault(
            accountId="-", vaultName=TEST_VAULT
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
