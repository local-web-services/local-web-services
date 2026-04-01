"""Given: the "organizations" "organizational unit" has child accounts"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient


@given('the "organizations" "organizational unit" has child accounts')
def ou_has_child_accounts(client: TestClient, world):
    account_id = OrganizationsTestClient(client).create_account()
    world["account_id"] = account_id
    OrganizationsTestClient(client).post(
        "MoveAccount",
        {
            "AccountId": account_id,
            "SourceParentId": world["root_id"],
            "DestinationParentId": world["ou_id"],
        },
    )
