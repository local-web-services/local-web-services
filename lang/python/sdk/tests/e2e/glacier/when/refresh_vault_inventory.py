"""When: a vault inventory is refreshed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when("a vault inventory is refreshed")
def refresh_vault_inventory(lws_session, world):
    try:
        result = lws_session.client("glacier").initiate_job(
            accountId="-",
            vaultName=world.get("vault_name", TEST_VAULT),
            jobParameters={"Type": "inventory-retrieval"},
        )
        world["result"] = result
        world["job_id"] = result.get("jobId")
        world["inventory_refreshed"] = True
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
