"""When: a "glacier" "vault" inventory retrieval job is initiated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when('a "glacier" "vault" inventory retrieval job is initiated')
def initiate_inventory_retrieval(lws_session, world):
    try:
        world["result"] = lws_session.client("glacier").initiate_job(
            accountId="-",
            vaultName=TEST_VAULT,
            jobParameters={"Type": "inventory-retrieval"},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
