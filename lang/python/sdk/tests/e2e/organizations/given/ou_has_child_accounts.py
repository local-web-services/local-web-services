"""Given: the organizational unit has child accounts"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("the organizational unit has child accounts")
def ou_has_child_accounts(lws_session, world):
    account_id = OrganizationsTestClient(lws_session).create_account()
    world["account_id"] = account_id
    OrganizationsTestClient(lws_session).move_account(
        AccountId=account_id, SourceParentId=world["root_id"], DestinationParentId=world["ou_id"]
    )
