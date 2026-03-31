"""When: an "organizations" "account" is created in the "organizations" "organization" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_ACCOUNT_EMAIL, INT_ACCOUNT_NAME


@when('an "organizations" "account" is created in the "organizations" "organization"')
def create_account(client: TestClient, world):
    status, body = OrganizationsTestClient(client).post(
        "CreateAccount", {"AccountName": INT_ACCOUNT_NAME, "Email": INT_ACCOUNT_EMAIL}
    )
    if status == 200:
        world["result"] = body
        world["account_id"] = body.get("CreateAccountStatus", {}).get("AccountId")
    else:
        world["error"] = body
