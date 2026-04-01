"""Given: the "organizations" "account" existed with tags"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OrganizationsTestClient
from ..constants import TEST_ACCOUNT_TAGS


@given('the "organizations" "account" existed with tags')
def account_existed_with_tags(lws_session, world):
    helper = OrganizationsTestClient(lws_session)
    account_id = helper.create_account()
    helper.tag_resource(account_id, TEST_ACCOUNT_TAGS)
    world["account_id"] = account_id
    world["account_tags"] = TEST_ACCOUNT_TAGS
