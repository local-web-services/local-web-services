"""Given: the account already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient


@given("the account already exists")
def account_already_exists(lws_session, world):
    world["account_id"] = OrganizationsTestClient(lws_session).create_account()
