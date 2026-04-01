"""Given: the "organizations" "account" existed under an "organizations" "organizational unit" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OrganizationsTestClient
from ..constants import INT_OU_NAME


@given('the "organizations" "account" existed under an "organizations" "organizational unit"')
def account_existed_under_ou(client: TestClient, world):
    helper = OrganizationsTestClient(client)
    root_id = world["root_id"]
    ou_id = helper.create_ou(root_id, INT_OU_NAME)
    account_id = helper.create_account()
    helper.move_account(account_id, root_id, ou_id)
    world["ou_id"] = ou_id
    world["account_id"] = account_id
