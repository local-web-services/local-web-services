"""Given: an account has been moved to a new parent"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("an account has been moved to a new parent")
def an_account_has_been_moved_to_a_new_parent(lws_session, world):
    OrganizationsTestClient(lws_session).create_org()
    world["root_id"] = OrganizationsTestClient(lws_session).get_root_id()
    account_id = OrganizationsTestClient(lws_session).create_account()
    dest_ou_id = OrganizationsTestClient(lws_session).create_ou(
        world["root_id"], "e2e-test-dest-ou-1"
    )
    OrganizationsTestClient(lws_session).move_account(
        AccountId=account_id, SourceParentId=world["root_id"], DestinationParentId=dest_ou_id
    )
