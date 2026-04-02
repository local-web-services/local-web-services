"""Given: the "organizations" "account" existed under an "organizations" "organizational unit" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient
from ..constants import TEST_OU_NAME


@given('the "organizations" "account" existed under an "organizations" "organizational unit"')
def account_existed_under_ou(lws_session, world):
    helper = OrganizationsTestClient(lws_session)
    root_id = world["root_id"]
    ou_id = helper.create_ou(root_id, TEST_OU_NAME)
    account_id = helper.create_account()
    helper.move_account(account_id, root_id, ou_id)
    world["ou_id"] = ou_id
    world["account_id"] = account_id
